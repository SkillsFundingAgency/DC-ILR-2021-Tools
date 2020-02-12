using System;
using System.Diagnostics;
using System.Text;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Serialization.Interfaces;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class AnnualMapper : IAnnualMapper
    {
        private readonly IFileService _fileService;
        private readonly IXmlSerializationService _xmlSerializationService;
        private readonly IMap<Loose.Previous.Message, Loose.Message> _mapper;
        private readonly IProcess<Loose.Message> _yearUplifter;
        private readonly IAnonymise<Loose.Message> _anonymiser;
        private readonly IAnonymiseLog _anonymiseLog;
        private readonly ILogger _logger;

        public AnnualMapper(
            IFileService fileService,
            IXmlSerializationService xmlSerializationService,
            IMap<Loose.Previous.Message, Loose.Message> mapper,
            IProcess<Loose.Message> yearUplifter,
            IAnonymise<Loose.Message> anonymiser,
            IAnonymiseLog anonymiseLog,
            ILogger logger)
        {
            _fileService = fileService;
            _xmlSerializationService = xmlSerializationService;
            _mapper = mapper;
            _yearUplifter = yearUplifter;
            _anonymiser = anonymiser;
            _anonymiseLog = anonymiseLog;
            _logger = logger;
        }

        public async Task<bool> MapFileAsync(string sourceFileReference, string sourceFileContainer, string targetFileReference, string targetFileContainer)
        {
            _logger.LogInfo($"Mapping {sourceFileReference} to {targetFileReference}");

            var timer = new Stopwatch();
            timer.Start();

            try
            {
                Loose.Previous.Message sourceMessage = null;

                using (var sourceStream = await _fileService.OpenReadStreamAsync(sourceFileReference, sourceFileContainer, new System.Threading.CancellationToken()))
                {
                    _logger.LogVerbose($"Read in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();

                    sourceMessage = _xmlSerializationService.Deserialize<Loose.Previous.Message>(sourceStream);
                    _logger.LogVerbose($"Deserialize in {timer.ElapsedMilliseconds}ms");
                    timer.Restart();
                }

                var targetMessage = _mapper.Map(sourceMessage);
                _logger.LogVerbose($"Mapped in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                var upliftedMessage = _yearUplifter.Process(targetMessage);
                _logger.LogVerbose($"Uplifted in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                var anonymisedMessage = _anonymiser.Process(upliftedMessage);
                _logger.LogVerbose($"Anonymised in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

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
                }
            }
            catch (Exception ex)
            {
                _logger.LogFatal($"Failed mapping {sourceFileReference} to {targetFileReference}", ex);
                return false;
            }

            return true;
        }
    }
}
