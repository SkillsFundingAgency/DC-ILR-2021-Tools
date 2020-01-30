using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Context
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
                await ProcessSingleFile(fileConversionContext.SourceFile, fileConversionContext.TargetFile, _annualMapper);
            }
            else
            {
                // IFileService will need to be extended to have ContainerExists and IterateContainerContents type functionality for this to work for both drives and blob stores
                var validsourceFolder = !string.IsNullOrWhiteSpace(fileConversionContext.SourceFolder) && Directory.Exists(fileConversionContext.SourceFolder);
                var validTargetFolder = !string.IsNullOrWhiteSpace(fileConversionContext.TargetFolder) && Directory.Exists(fileConversionContext.TargetFolder);

                if (validsourceFolder && validTargetFolder)
                {
                    ProcessFolder(fileConversionContext.SourceFolder, fileConversionContext.TargetFolder, _annualMapper);
                }
                else
                { // There is not a valid set of files or folders to be able to progess further.
                    throw new ArgumentException("Invalid command line parameters supplied");
                }
            }
        }

        private static void ProcessFolder(string sourceFolder, string targetFolder, IAnnualMapper annualMapper)
        {
            System.Console.WriteLine($"To be implemented - process all files in {sourceFolder} to {targetFolder} using {annualMapper}");
            throw new NotImplementedException();
        }

        private static async Task ProcessSingleFile(string sourceFile, string targetFile, IAnnualMapper annualMapper)
        {
            await annualMapper.MapFileAsync(sourceFile, targetFile);
        }
    }
}
