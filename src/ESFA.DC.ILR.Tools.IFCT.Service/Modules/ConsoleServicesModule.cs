using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Service.Context;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Serialization.Interfaces;
using ESFA.DC.Serialization.Xml;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class ConsoleServicesModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Interfaces at the Servic level
            containerBuilder.RegisterType<ConsoleService>().As<IConsoleService>();
            containerBuilder.RegisterType<AnnualMapperConfiguration>().As<IAnnualMapperConfiguration>().SingleInstance();
            containerBuilder.RegisterType<MapperProvider>().As<IMapperProvider>();
            containerBuilder.RegisterType<MessageMapper>().As<IMap<Loose.Previous.Message, Loose.Message>>();
            containerBuilder.RegisterType<AnnualMapper>().As<IAnnualMapper>();

            containerBuilder.RegisterType<TempLogger>().As<ILogger>();

            containerBuilder.RegisterType<XmlSerializationService>().As<IXmlSerializationService>();
        }
    }
}
