using System;
using Autofac;
using CommandLine;
using ESFA.DC.ILR.Tools.IFCT.Console.Modules;
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
                                TargetFile = cla.TargetFile,
                            };
                            logger.LogDebug("Starting processing");
                            await consoleService.ProcessFilesAsync(context);
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

            System.Console.Write("Press any key to continue...");
            System.Console.ReadKey();
        }

        private static void DisplayArgumentsError()
        {
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"IFCT Console");
            System.Console.WriteLine();
            System.Console.ForegroundColor = ConsoleColor.Red;
            System.Console.WriteLine(@"A matching source and target file required.");
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine(@"
  -s, --source          Required. Provide File Path for source ILR File.

  -t, --target          Reuired. Provide File Path for target ILR File.");
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

            containerBuilder.RegisterModule<ConsoleServicesModule>();
            containerBuilder.RegisterModule<ConsoleModule>();
            containerBuilder.RegisterModule(new LoggingModule(settings));
            containerBuilder.RegisterModule<FileValidationModule>();

            return containerBuilder;
        }
    }
}
