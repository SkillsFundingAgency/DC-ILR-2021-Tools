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
        private readonly IFileService _fileService;
        private readonly IFileConversionOrchestrator _fileConversionOrchestrator;

        public ConsoleService(IFileConversionOrchestrator fileConversionOrchestrator, IFileService fileService)
        {
            _fileService = fileService;
            _fileConversionOrchestrator = fileConversionOrchestrator;
        }

        public async Task<bool> ProcessFilesAsync(IFileConversionContext fileConversionContext, Action<string> progressCallback)
        {
            if (fileConversionContext == null)
            {
                throw new ArgumentNullException(nameof(fileConversionContext));
            }

            // Using Directory here as this is the *ConsoleService* which will be used in console and WPF app, and expect windows file system.
            // Perhaps useful to add a ContainerExists to the IFileService then this could be generic.
            var validSingeSourceFile = !string.IsNullOrWhiteSpace(fileConversionContext.SourceFile) &&
                await _fileService.ExistsAsync(fileConversionContext.SourceFile, null, new CancellationToken());
            var validSingleTargetFolder = !string.IsNullOrWhiteSpace(fileConversionContext.TargetFolder)
                && Directory.Exists(fileConversionContext.TargetFolder);

            if (validSingeSourceFile && validSingleTargetFolder)
            {
                // process single file
                var result = await ProcessSingleFile(fileConversionContext.SourceFile, fileConversionContext.TargetFolder, progressCallback);
                return result;
            }
            else
            {
                // There is not a valid set of files or folders to be able to progess further.
                throw new ArgumentException("Invalid command line parameters supplied");
            }
        }

        private async Task<bool> ProcessSingleFile(string sourceFile, string targetFolder, Action<string> progressCallback)
        {
            return await _fileConversionOrchestrator.MapFileAsync(Path.GetFileName(sourceFile), Path.GetDirectoryName(sourceFile), targetFolder, progressCallback);
        }
    }
}
