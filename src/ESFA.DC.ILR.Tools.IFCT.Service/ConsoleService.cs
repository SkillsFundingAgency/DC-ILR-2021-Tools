using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class ConsoleService : IConsoleService
    {
        private readonly IAnnualMapper _annualMapper;
        private readonly IFileService _fileService;

        public ConsoleService(IAnnualMapper annualMapper, IFileService fileService)
        {
            _annualMapper = annualMapper;
            _fileService = fileService;
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
            { // process single file
                // TODO: validate source file
                await ProcessSingleFile(fileConversionContext.SourceFile, fileConversionContext.TargetFile, _annualMapper);
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

        private static bool ValidateSchema(string sourceFile, string xsdSchema)
        {

        }
    }
}
