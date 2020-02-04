using Autofac;
using ESFA.DC.ILR.Tools.IFCT.FileValidation;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.ILR.Model.Loose.Previous.FileValidation;

namespace ESFA.DC.ILR.Tools.IFCT.Console.Modules
{
    public class FileValidationModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<ValidationErrorHandler>().As<IValidationErrorHandler>();
            containerBuilder.RegisterType<XmlSchemaProvider>().As<IXmlSchemaProvider>();
            containerBuilder.RegisterType<ValidationErrorMetadataService>().As<IValidationErrorMetadataService>();
            containerBuilder.RegisterType<XsdValidationService>().As<IXsdValidationService>();
        }
    }
}
