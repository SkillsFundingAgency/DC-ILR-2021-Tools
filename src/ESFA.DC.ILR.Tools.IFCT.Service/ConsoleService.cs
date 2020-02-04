using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class ConsoleService : IConsoleService
    {
        private readonly IAnnualMapper _annualMapper;
        private readonly IFileService _fileService;
        private readonly IXsdValidationService _xsdValidationService;

        public ConsoleService(IAnnualMapper annualMapper, IFileService fileService, IXsdValidationService xsdValidationService)
        {
            _annualMapper = annualMapper;
            _fileService = fileService;
            _xsdValidationService = xsdValidationService;
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
                if (await ValidateSchema(fileConversionContext.SourceFile, _fileService, _xsdValidationService))
                {
                    await ProcessSingleFile(fileConversionContext.SourceFile, fileConversionContext.TargetFile, _annualMapper);
                }
            }
            else
            {
                // There is not a valid set of files or folders to be able to progess further.
                throw new ArgumentException("Invalid command line parameters supplied");
            }
        }

        private static async Task ProcessSingleFile(string sourceFile, string targetFile, IAnnualMapper annualMapper)
        {
            await annualMapper.MapFileAsync(sourceFile, targetFile);
        }

        private static async Task<bool> ValidateSchema(string sourceFile, IFileService fileService, IXsdValidationService xsdValidationService)
        {
            using (Stream xmlStream = await fileService.OpenReadStreamAsync(sourceFile, null, new CancellationToken()))
            {
                xsdValidationService.Validate(xmlStream);
                return true;
            }
        }
    }
}
