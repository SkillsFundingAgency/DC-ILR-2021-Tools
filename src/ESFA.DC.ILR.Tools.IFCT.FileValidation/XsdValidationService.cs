﻿using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using System.IO;
using System.Xml;
using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation
{
    public class XsdValidationService : IXsdValidationService
    {
        public void Validate(Stream stream, XmlSchemaSet xmlSchemaSet, ValidationEventHandler validationEventHandler = null)
        {
            var xmlReaderSettings = BuildReaderSettings(xmlSchemaSet, validationEventHandler);

            stream.Position = 0;
            using (var xmlReader = XmlReader.Create(stream, xmlReaderSettings))
            {
                while (xmlReader.Read())
                {
                }
            }
        }

        public void ValidateNamespace(Stream stream, XmlSchemaSet xmlSchemaSet, string rootElementName, ValidationEventHandler validationEventHandler = null)
        {
            var xmlReaderSettings = BuildXmlNsReaderSettings(xmlSchemaSet, validationEventHandler);

            using (var xmlReader = XmlReader.Create(stream, xmlReaderSettings))
            {
                try
                {
                    xmlReader.ReadToFollowing(rootElementName);
                }
                catch (XmlException xmlException)
                {
                    throw xmlException;
                }
            }
        }

        private XmlReaderSettings BuildXmlNsReaderSettings(XmlSchemaSet xmlSchemaSet, ValidationEventHandler validationEventHandler = null)
        {
            var settings = BuildReaderSettings(xmlSchemaSet, validationEventHandler);
            settings.ValidationFlags |= XmlSchemaValidationFlags.ReportValidationWarnings;
            int flag = (int) settings.ValidationFlags;
            return settings;
        }

        private XmlReaderSettings BuildReaderSettings(XmlSchemaSet xmlSchemaSet, ValidationEventHandler validationEventHandler = null)
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
    }
}
