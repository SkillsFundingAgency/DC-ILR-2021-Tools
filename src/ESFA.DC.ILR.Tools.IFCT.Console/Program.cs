using System;
using System.IO;
using System.Threading.Tasks;
using Autofac;
using CommandLine;
using ESFA.DC.ILR.Tools.IFCT.Console.Modules;
using ESFA.DC.ILR.Tools.IFCT.Service;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Parser.Default.ParseArguments<CommandLineArguments>(args)
                .WithParsed(async a =>
                {
                    try
                    { // ArgumentException for parameters ??????
                        using (var container = BuildContainerBuilder().Build())
                        {
                            var annualMapper = container.Resolve<IAnnualMapper>();

                            var validSingeSourceFile = !string.IsNullOrWhiteSpace(a.SourceFile) && File.Exists(a.SourceFile);
                            var validSingleTargetFile = !string.IsNullOrWhiteSpace(a.TargetFile);

                            if (validSingeSourceFile && validSingleTargetFile)
                            { // process single file
                                await ProcessSingleFile(a.SourceFile, a.TargetFile, annualMapper);
                            }
                            else
                            {
                                var validsourceFolder = !string.IsNullOrWhiteSpace(a.SourceFolder) && Directory.Exists(a.SourceFolder);
                                var validTargetFolder = !string.IsNullOrWhiteSpace(a.TargetFolder) && Directory.Exists(a.TargetFolder);

                                if (validsourceFolder && validTargetFolder)
                                {
                                    ProcessFolder(a.SourceFolder, a.TargetFolder, annualMapper);
                                }
                                else
                                { // There is not a valid set of files or folders to be able to progess further.
                                    DisplayArgumentsError();
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Console.WriteLine($"Error - {ex.Message}");
                    }
                });

            // Remove this !
            System.Console.WriteLine("Press any key");
            System.Console.Read();
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

        private static void DisplayArgumentsError()
        {
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"IFCT Console");
            System.Console.WriteLine();
            System.Console.ForegroundColor = ConsoleColor.Red;
            System.Console.WriteLine(@"Either a matching source and target file or a source and target folder are required.");
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"
  -s, --source          Required. Provide File Path for source ILR File.

  -t, --target          Provide File Path for target ILR File.

  -f, --sourcefolder    Provide File Path for source folder of ILR Files.

  -r, --resultfolder    Provide File Path for result folder of ILR Files.");
        }

        private static ContainerBuilder BuildContainerBuilder()
        {
            var containerBuilder = new ContainerBuilder();

            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appSettings.json");
            var config = configBuilder.Build();

            containerBuilder.RegisterInstance<IConfiguration>(config);

            containerBuilder.RegisterModule<ConsoleServicesModule>();
            containerBuilder.RegisterModule<ConsoleModule>();

            return containerBuilder;
        }
    }
}
