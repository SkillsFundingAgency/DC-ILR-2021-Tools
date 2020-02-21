using System;
using Autofac;
using CommandLine;
using ESFA.DC.ILR.Tools.IFCT.Common;
using ESFA.DC.ILR.Tools.IFCT.Console.Modules;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Modules;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Logging.Desktop.Config;
using ESFA.DC.Logging.Desktop.Config.Interfaces;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            using (var container = BuildContainerBuilder().Build())
            {
                var logger = container.Resolve<ILogger>();
                Parser.Default.ParseArguments<CommandLineArguments>(args)
                    .WithParsed(async cla =>
                    {
                        try
                        {
                            // ArgumentException for parameters ??????
                            var consoleService = container.Resolve<IConsoleService>();

                            // possible factory here
                            var context = new FileConversionContext
                            {
                                SourceFile = cla.SourceFile,
                                TargetFolder = cla.TargetFolder,
                            };
                            logger.LogDebug("Starting processing");

                            var result = await consoleService.ProcessFilesAsync(context, s => System.Console.WriteLine(s));
                            System.Console.WriteLine(result ? "Processing completed successfully" : "Processing failed, please check logs");
                        }
                        catch (ArgumentException ae)
                        {
                            logger.LogError("No Arguments found", ae);
                            DisplayArgumentsError();
                        }
                        catch (Exception ex)
                        {
                            logger.LogError("An Error has occurred", ex);
                            System.Console.WriteLine($"Error - {ex.Message}");
                        }
                    });
            }

            System.Console.ReadLine();
        }

        private static void DisplayArgumentsError()
        {
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"IFCT Console");
            System.Console.WriteLine();
            System.Console.ForegroundColor = ConsoleColor.Red;
            System.Console.WriteLine(@"A source file and target folder are both required.");
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"
  -s, --source          Required. Provide complete File Path for source ILR File.

  -t, --target          Reuired. Provide folder for target ILR File.");
        }

        private static ContainerBuilder BuildContainerBuilder()
        {
            var containerBuilder = new ContainerBuilder();
            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appSettings.json");
            IConfiguration config = configBuilder.Build();

            // bind logger settings
            DesktopLoggerSettings settings = new DesktopLoggerSettings();
            config.GetSection("Logging").Bind(settings);
            containerBuilder.RegisterInstance<IConfiguration>(config);
            containerBuilder.RegisterInstance<IDesktopLoggerSettings>(settings);

            containerBuilder.RegisterType<ModelRecurser>().As<IModelRecurser>();

            containerBuilder.RegisterModule<ConsoleServicesModule>();
            containerBuilder.RegisterModule<ConsoleModule>();
            containerBuilder.RegisterModule(new LoggingModule(settings));
            containerBuilder.RegisterModule<FileValidationModule>();
            containerBuilder.RegisterModule<YearUplifterModule>();
            containerBuilder.RegisterModule<AnonymiserModule>();

            return containerBuilder;
        }
    }
}
