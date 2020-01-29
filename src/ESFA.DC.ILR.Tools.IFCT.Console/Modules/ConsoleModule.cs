using Autofac;
using ESFA.DC.FileService;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Serialization.Interfaces;
using ESFA.DC.Serialization.Xml;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Console.Modules
{
    public class ConsoleModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Presume we are using drive not blob store at this point - want to do this by config later?
            containerBuilder.RegisterType<FileSystemFileService>().As<IFileService>();
        }
    }
}
