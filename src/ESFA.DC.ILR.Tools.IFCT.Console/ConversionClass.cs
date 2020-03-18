using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Autofac;
using CommandLine;
using ESFA.DC.ILR.Tools.IFCT.Common;
using ESFA.DC.ILR.Tools.IFCT.Console.Modules;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Modules;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Message;
using ESFA.DC.Logging.Desktop.Config;
using ESFA.DC.Logging.Desktop.Config.Interfaces;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public class ConversionClass
    {
        public void ConvertFile(string[] args)
        {
            using (var container = BuildContainerBuilder().Build())
            {
                var logger = container.Resolve<ILogger>();
                var messengerService = container.Resolve<IMessengerService>();
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

                            messengerService.Register<TaskProgressMessage>(this, HandleTaskProgressMessage);

                            logger.LogDebug("Starting processing");
                            System.Console.WriteLine("IFCT Console" + Environment.NewLine + Environment.NewLine);

                            Task<bool> task = Task.Run<bool>(async () => await consoleService.ProcessFilesAsync(context, new CancellationToken()));
                            var result = task.Result;

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
        }

        public static void ClearCurrentConsoleLine()
        {
            int currentLineCursor = System.Console.CursorTop;
            System.Console.SetCursorPosition(0, System.Console.CursorTop);
            System.Console.Write(new string(' ', System.Console.WindowWidth));
            System.Console.SetCursorPosition(0, currentLineCursor);
        }

        public static void OverwriteConsoleText(string newMessage)
        {
            System.Console.SetCursorPosition(0, System.Console.CursorTop - 1);
            ClearCurrentConsoleLine();
            System.Console.WriteLine(newMessage);
        }

        public static void HandleTaskProgressMessage(TaskProgressMessage taskProgressMessage)
        {
            OverwriteConsoleText(taskProgressMessage.TaskName);
        }

        private static void DisplayArgumentsError()
        {
            System.Console.ForegroundColor = ConsoleColor.White;
            System.Console.WriteLine("IFCT Console");
            System.Console.WriteLine();
            System.Console.ForegroundColor = ConsoleColor.Red;
            System.Console.WriteLine("A source file and target folder are both required.");
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
