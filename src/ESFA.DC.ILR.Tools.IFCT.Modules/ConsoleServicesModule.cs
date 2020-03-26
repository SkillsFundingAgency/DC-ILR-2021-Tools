using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate;
using ESFA.DC.Serialization.Interfaces;
using ESFA.DC.Serialization.Xml;

namespace ESFA.DC.ILR.Tools.IFCT.Modules
{
    public class ConsoleServicesModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Interfaces at the Servic level
            containerBuilder.RegisterType<CommandLineMessengerService>().As<IMessengerService>().SingleInstance();
            containerBuilder.RegisterType<ConsoleService>().As<IConsoleService>();
            containerBuilder.RegisterType<FileNameService>().As<IFileNameService>();
            containerBuilder.RegisterType<FileConversionOrchestratorConfiguration>().As<IFileConversionOrchestratorConfiguration>().SingleInstance();
            containerBuilder.RegisterType<MapperProvider>().As<IMapperProvider>();
            containerBuilder.RegisterType<MessageMapper>().As<IMap<Loose.Previous.Message, Loose.Message>>();
            containerBuilder.RegisterType<FileConversionOrchestrator>().As<IFileConversionOrchestrator>();
            containerBuilder.RegisterType<YearUpdater>().As<IProcess<Loose.Message>>();

            containerBuilder.RegisterType<XmlSerializationService>().As<IXmlSerializationService>();
        }
    }
}
