using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Schema;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Logging.Interfaces;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class ConsoleService : IConsoleService
    {
        private readonly IAnnualMapper _annualMapper;
        private readonly IFileService _fileService;
        private readonly IXsdValidationService _xsdValidationService;
        private readonly IXmlSchemaProvider _xmlSchemaProvider;
        private readonly IValidationErrorHandler _validationErrorHandler;
        private readonly IFileNameService _fileNameService;

        public ConsoleService(IAnnualMapper annualMapper, IFileNameService fileNameService, IFileService fileService, IXsdValidationService xsdValidationService, IXmlSchemaProvider xmlSchemaProvider, IValidationErrorHandler validationErrorHandler)
        {
            _annualMapper = annualMapper;
            _fileService = fileService;
            _xsdValidationService = xsdValidationService;
            _xmlSchemaProvider = xmlSchemaProvider;
            _validationErrorHandler = validationErrorHandler;
            _fileNameService = fileNameService;
        }

        private static string RetrieveRootElement(XmlSchema xmlSchema)
        {
            return xmlSchema.Items.OfType<XmlSchemaElement>().FirstOrDefault()?.Name;
        }

        public async Task ProcessFilesAsync(IFileConversionContext fileConversionContext)
        {
            if (fileConversionContext == null)
            {
                throw new ArgumentNullException(nameof(fileConversionContext));
            }

            var validSingeSourceFile = !string.IsNullOrWhiteSpace(fileConversionContext.SourceFile) &&
                await _fileService.ExistsAsync(fileConversionContext.SourceFile, null, new CancellationToken());
            var validSingleTargetFile = !string.IsNullOrWhiteSpace(fileConversionContext.TargetFile);

            if (validSingeSourceFile && validSingleTargetFile)
            {
                // process single file

                string targetFilename = GenerateOutputName(fileConversionContext.SourceFile);

                if (await ValidateSchema(fileConversionContext.SourceFile))
                {
                    await ProcessSingleFile(fileConversionContext.SourceFile, targetFilename, _annualMapper);
                }
            }
            else
            {
                // There is not a valid set of files or folders to be able to progess further.
                throw new ArgumentException("Invalid command line parameters supplied");
            }
        }

        private string GenerateOutputName(string currentFile)
        {
            string filePath = Path.GetDirectoryName(currentFile);
            string fileExtension = Path.GetExtension(currentFile);
            string fileName = _fileNameService.NameGeneration(Path.GetFileName(currentFile));
            return filePath + fileName + fileExtension;
        }

        private async Task ProcessSingleFile(string sourceFile, string targetFile, IAnnualMapper annualMapper)
        {
            await annualMapper.MapFileAsync(sourceFile, targetFile);
        }

        private async Task<bool> ValidateSchema(string sourceFile)
        {
            XmlSchema schema = _xmlSchemaProvider.Provide();
            XmlSchemaSet xmlSchemaSet = new XmlSchemaSet();
            xmlSchemaSet.Add(schema);
            xmlSchemaSet.Compile();
            using (Stream xmlStream = await _fileService.OpenReadStreamAsync(sourceFile, null, new CancellationToken()))
            {
                _xsdValidationService.ValidateNamespace(xmlStream, xmlSchemaSet, RetrieveRootElement(schema), _validationErrorHandler.XsdNsValidationErrorHandler);
                _xsdValidationService.Validate(xmlStream, xmlSchemaSet, _validationErrorHandler.XsdValidationErrorHandler);
                return true;
            }
        }
    }
}
