using System;
using System.IO;
using System.Threading.Tasks;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Context
{
    public class ConsoleService : IConsoleService
    {
        private readonly IAnnualMapper _annualMapper;

        public ConsoleService(IAnnualMapper annualMapper)
        {
            _annualMapper = annualMapper;
        }

        public async Task ProcessFiles(IFileConversionContext fileConversionContext)
        {
            if (fileConversionContext == null)
            {
                throw new Exception("No command line arguments supplied");
            }

            var validSingeSourceFile = !string.IsNullOrWhiteSpace(fileConversionContext.SourceFile) && File.Exists(fileConversionContext.SourceFile);
            var validSingleTargetFile = !string.IsNullOrWhiteSpace(fileConversionContext.TargetFile);

            if (validSingeSourceFile && validSingleTargetFile)
            { // process single file
                await ProcessSingleFile(fileConversionContext.SourceFile, fileConversionContext.TargetFile, _annualMapper);
            }
            else
            {
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
