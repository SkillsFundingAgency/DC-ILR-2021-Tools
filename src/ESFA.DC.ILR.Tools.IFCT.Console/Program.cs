using System;
using Autofac;
using CommandLine;
using ESFA.DC.ILR.Tools.IFCT.Console.Modules;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            Parser.Default.ParseArguments<CommandLineArguments>(args)
                .WithParsed(async cla =>
                {
                    try
                    { // ArgumentException for parameters ??????
                        using (var container = BuildContainerBuilder().Build())
                        {
                            var consoleService = container.Resolve<IConsoleService>();

                            // possible factory here
                            var context = new FileConversionContext
                            {
                                SourceFile = cla.SourceFile,
                                TargetFile = cla.TargetFile,
                            };

                            await consoleService.ProcessFilesAsync(context);
                        }
                    }
                    catch (ArgumentException)
                    {
                        DisplayArgumentsError();
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
            var config = configBuilder.Build();

            containerBuilder.RegisterInstance<IConfiguration>(config);

            containerBuilder.RegisterModule<ConsoleServicesModule>();
            containerBuilder.RegisterModule<ConsoleModule>();

            return containerBuilder;
        }
    }
}
