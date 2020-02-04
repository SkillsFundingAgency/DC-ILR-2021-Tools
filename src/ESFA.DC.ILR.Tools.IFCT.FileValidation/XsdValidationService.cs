using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation
{
    public class XsdValidationService : IXsdValidationService
    {
        private readonly IIlrLooseXmlSchemaProvider _xmlSchemaProvider;
        private readonly IValidationErrorHandler _validationErrorHandler;
        private readonly IValidationErrorMetadataService _validationErrorMetadataService;

        public XsdValidationService(IIlrLooseXmlSchemaProvider xmlSchemaProvider, IValidationErrorHandler validationErrorHandler, IValidationErrorMetadataService validationErrorMetadataService)
        {
            _xmlSchemaProvider = xmlSchemaProvider;
            _validationErrorHandler = validationErrorHandler;
            _validationErrorMetadataService = validationErrorMetadataService;
        }

        public void Validate(Stream stream)
        {
            var xmlSchemaSet = BuildXmlSchemaSet();
            var xmlReaderSettings = BuildXmlReaderSettings(xmlSchemaSet);

            ValidateNamespace(stream, xmlSchemaSet);

            stream.Position = 0;
            using (var xmlReader = XmlReader.Create(stream, xmlReaderSettings))
            {
                try
                {
                    while (xmlReader.Read())
                    {
                    }
                }
                catch (XmlException xmlException)
                {
                    _validationErrorHandler.XmlValidationErrorHandler(xmlException);
                    throw;
                }
            }

            AssertValidity();
        }

        public void ValidateNamespace(Stream stream, XmlSchemaSet xmlSchemaSet)
        {
            var xmlReaderSettings = BuildXmlNsReaderSettings(xmlSchemaSet);

            using (var xmlReader = XmlReader.Create(stream, xmlReaderSettings))
            {
                try
                {
                    xmlReader.ReadToFollowing(this.RetrieveRootElementName());
                }
                catch (XmlException xmlException)
                {
                    _validationErrorHandler.XmlValidationErrorHandler(xmlException);
                    throw;
                }
            }

            AssertValidity();
        }


        public void AssertValidity()
        {
            if (!_validationErrorMetadataService.IsSchemaValid(_validationErrorHandler.ValidationErrors))
            {
                throw new XmlSchemaException("Supplied XML does not conform to the XSD, see Validation Errors for Detailed Results.");
            }
        }

        public XmlSchemaSet BuildXmlSchemaSet()
        {
            var xmlSchemaSet = new XmlSchemaSet()
            {
                CompilationSettings = new XmlSchemaCompilationSettings()
            };

            var xmlSchema = _xmlSchemaProvider.Provide();

            xmlSchemaSet.Add(xmlSchema);
            xmlSchemaSet.Compile();

            return xmlSchemaSet;
        }

        public XmlReaderSettings BuildXmlReaderSettings(XmlSchemaSet xmlSchemaSet)
        {
            return BuildReaderSettings(xmlSchemaSet, _validationErrorHandler.XsdValidationErrorHandler);
        }

        public XmlReaderSettings BuildXmlNsReaderSettings(XmlSchemaSet xmlSchemaSet)
        {
            var settings = BuildReaderSettings(xmlSchemaSet, _validationErrorHandler.XsdNsValidationErrorHandler);
            settings.ValidationFlags |= XmlSchemaValidationFlags.ReportValidationWarnings;

            return settings;
        }

        public XmlReaderSettings BuildReaderSettings(XmlSchemaSet xmlSchemaSet, ValidationEventHandler validationEventHandler)
        {
            var settings = new XmlReaderSettings
            {
                CloseInput = false,
                ValidationType = ValidationType.Schema,
                Schemas = xmlSchemaSet,
                ValidationFlags = XmlSchemaValidationFlags.ProcessIdentityConstraints
            };

            settings.ValidationEventHandler += validationEventHandler;

            return settings;
        }

        public string RetrieveRootElementName()
        {
            var xmlSchema = _xmlSchemaProvider.Provide();
            return xmlSchema.Items.OfType<XmlSchemaElement>().FirstOrDefault()?.Name;
        }
    }
}
