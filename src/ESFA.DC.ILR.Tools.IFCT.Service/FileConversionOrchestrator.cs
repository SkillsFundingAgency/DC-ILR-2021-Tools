using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Serialization.Interfaces;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class FileConversionOrchestrator : IFileConversionOrchestrator
    {
        private readonly IFileService _fileService;

        private readonly IFileNameService _fileNameService;

        private readonly IXsdValidationService _xsdValidationService;
        private readonly IXmlSchemaProvider _xmlSchemaProvider;
        private readonly IValidationErrorHandler _validationErrorHandler;

        private readonly IXmlSerializationService _xmlSerializationService;
        private readonly IMap<Loose.Previous.Message, Loose.Message> _mapper;
        private readonly IProcess<Loose.Message> _yearUplifter;
        private readonly IAnonymise<Loose.Message> _anonymiser;
        private readonly IAnonymiseLog _anonymiseLog;
        private readonly ILogger _logger;

        public FileConversionOrchestrator(
            IFileService fileService,
            IFileNameService fileNameService,
            IXsdValidationService xsdValidationService,
            IXmlSchemaProvider xmlSchemaProvider,
            IValidationErrorHandler validationErrorHandler,
            IXmlSerializationService xmlSerializationService,
            IMap<Loose.Previous.Message, Loose.Message> mapper,
            IProcess<Loose.Message> yearUplifter,
            IAnonymise<Loose.Message> anonymiser,
            IAnonymiseLog anonymiseLog,
            ILogger logger)
        {
            _fileService = fileService;
            _fileNameService = fileNameService;
            _xsdValidationService = xsdValidationService;
            _xmlSchemaProvider = xmlSchemaProvider;
            _validationErrorHandler = validationErrorHandler;
            _xmlSerializationService = xmlSerializationService;
            _mapper = mapper;
            _yearUplifter = yearUplifter;
            _anonymiser = anonymiser;
            _anonymiseLog = anonymiseLog;
            _logger = logger;
        }

        public async Task<bool> MapFileAsync(string sourceFileReference, string sourceFileContainer, string targetFileContainer, Action<string> progressCallback)
        {
            _logger.LogInfo($"Mapping {sourceFileReference} into {targetFileContainer}");

            var timer = new Stopwatch();
            timer.Start();

            try
            {
                progressCallback?.Invoke("Starting");

                // Generate new filename
                var targetFileReference = GenerateOutputName(sourceFileReference);
                _logger.LogInfo($"Updated filename from {sourceFileReference} is {targetFileReference}");

                // Need to do extract from zip (if relevant) here
                Loose.Previous.Message sourceMessage = null;

                using (var sourceStream = await _fileService.OpenReadStreamAsync(sourceFileReference, sourceFileContainer, new System.Threading.CancellationToken()))
                {
                    _logger.LogVerbose($"Read in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();

                    // Validation against XSD
                    if (!ValidateSchema(sourceStream))
                    {
                        return false;
                    }

                    _logger.LogVerbose($"Schema validated in {timer.ElapsedMilliseconds}ms");
                    progressCallback?.Invoke("Schema validated");
                    timer.Restart();

                    sourceMessage = _xmlSerializationService.Deserialize<Loose.Previous.Message>(sourceStream);
                    _logger.LogVerbose($"Deserialize in {timer.ElapsedMilliseconds}ms");
                    progressCallback?.Invoke("File loaded");
                    timer.Restart();
                }

                // Map from previous year to current year structure via automapper
                var targetMessage = _mapper.Map(sourceMessage);
                _logger.LogVerbose($"Mapped in {timer.ElapsedMilliseconds}ms");
                progressCallback?.Invoke("Mapped to current year structure");
                timer.Restart();

                // Uplift any relevant values in the current year structure
                var upliftedMessage = _yearUplifter.Process(targetMessage);
                _logger.LogVerbose($"Uplifted in {timer.ElapsedMilliseconds}ms");
                progressCallback?.Invoke("Values uplifted for current year");
                timer.Restart();

                // Anonymise any PII information in the current year structure
                var anonymisedMessage = _anonymiser.Process(upliftedMessage);
                _logger.LogVerbose($"Anonymised in {timer.ElapsedMilliseconds}ms");
                progressCallback?.Invoke("Anonymised for current year");
                timer.Restart();

                // Write out the current year structure
                using (var targetStream = await _fileService.OpenWriteStreamAsync(targetFileReference, targetFileContainer, new System.Threading.CancellationToken()))
                {
                    _logger.LogVerbose($"Get Out Stream in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();

                    _xmlSerializationService.Serialize<Loose.Message>(anonymisedMessage, targetStream);
                    _logger.LogVerbose($"Serialize in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();

                    await targetStream.FlushAsync();
                    _logger.LogVerbose($"Flush in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();
                }

                // Write out the anonymisation lookup details (LRN and ULN)
                using (var targetStream = await _fileService.OpenWriteStreamAsync(targetFileReference + ".CSV", targetFileContainer, new System.Threading.CancellationToken()))
                {
                    var newLineBytes = Encoding.ASCII.GetBytes(Environment.NewLine);
                    foreach (var logEntry in _anonymiseLog.Log)
                    {
                        var reportLine = $"{logEntry.FieldName} {logEntry.OldValue} {logEntry.NewValue}";
                        var reportLineBytes = Encoding.ASCII.GetBytes(reportLine);
                        targetStream.Write(reportLineBytes, 0, reportLineBytes.Length);
                        targetStream.Write(newLineBytes, 0, newLineBytes.Length);
                    }

                    await targetStream.FlushAsync();
                    _anonymiseLog.Clear();
                }

                progressCallback?.Invoke("File saved - Completed");
            }
            catch (Exception ex)
            {
                _logger.LogFatal($"Failed mapping {sourceFileReference} into {targetFileContainer}", ex);
                return false;
            }

            return true;
        }

        private string GenerateOutputName(string currentFile)
        {
            string fileExtension = Path.GetExtension(currentFile);
            string fileName = _fileNameService.Generate(Path.GetFileNameWithoutExtension(Path.GetFileName(currentFile)));
            return fileName + fileExtension;
        }

        private static string RetrieveRootElement(XmlSchema xmlSchema)
        {
            return xmlSchema.Items.OfType<XmlSchemaElement>().FirstOrDefault()?.Name;
        }

        private bool ValidateSchema(Stream sourceFileStream)
        {
            // Ensure we are at the start of the stream
            sourceFileStream.Seek(0, SeekOrigin.Begin);

            XmlSchema schema = _xmlSchemaProvider.Provide();
            XmlSchemaSet xmlSchemaSet = new XmlSchemaSet();
            xmlSchemaSet.Add(schema);
            xmlSchemaSet.Compile();
            _xsdValidationService.ValidateNamespace(sourceFileStream, xmlSchemaSet, RetrieveRootElement(schema), _validationErrorHandler.XsdNsValidationErrorHandler);
            _xsdValidationService.Validate(sourceFileStream, xmlSchemaSet, _validationErrorHandler.XsdValidationErrorHandler);
            return true;
        }
    }
}
