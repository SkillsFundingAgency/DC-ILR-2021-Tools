using System.Windows;
using Autofac;
using Autofac.Extras.CommonServiceLocator;
using CommonServiceLocator;
using ESFA.DC.FileService;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Desktop.WPF.Modules;
using ESFA.DC.ILR.Tools.IFCT.Common;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Modules;
using ESFA.DC.Logging.Desktop.Config;
using ESFA.DC.Logging.Desktop.Config.Interfaces;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.WPF
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            var containerBuilder = BuildContainerBuilder();

            var container = containerBuilder.Build();

            ServiceLocator.SetLocatorProvider(() => new AutofacServiceLocator(container));

            var logger = container.Resolve<ILogger>();
            logger.LogInfo("ILR File Conversion Application Start");

            base.OnStartup(e);
        }

        private ContainerBuilder BuildContainerBuilder()
        {
            var containerBuilder = new ContainerBuilder();

            // WPF Views
            containerBuilder.RegisterModule<ViewModelsModule>();

            // Configuration
            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appSettings.json");
            IConfiguration config = configBuilder.Build();

            // Logging
            DesktopLoggerSettings settings = new DesktopLoggerSettings();
            config.GetSection("Logging").Bind(settings);
            containerBuilder.RegisterInstance<IConfiguration>(config);
            containerBuilder.RegisterInstance<IDesktopLoggerSettings>(settings);
            containerBuilder.RegisterModule(new LoggingModule(settings));

            // Conversion process
            containerBuilder.RegisterType<ModelRecurser>().As<IModelRecurser>();
            containerBuilder.RegisterType<FileSystemFileService>().As<IFileService>();
            containerBuilder.RegisterModule<ConsoleServicesModule>();
            containerBuilder.RegisterModule(new LoggingModule(settings));
            containerBuilder.RegisterModule<FileValidationModule>();
            containerBuilder.RegisterModule<YearUplifterModule>();
            containerBuilder.RegisterModule<AnonymiserModule>();

            return containerBuilder;
        }
    }
}
