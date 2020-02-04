﻿using System.IO;
using System.Linq;
using System.Reflection;
using System.Xml;
using System.Xml.Schema;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;

namespace ESFA.DC.ILR.Tools.ILR.Model.Loose.Previous.FileValidation
{
    public class IlrLooseXmlSchemaProvider : IIlrLooseXmlSchemaProvider
    {
        public XmlSchema Provide()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var xsdResourceName = assembly.GetManifestResourceNames().First(n => n.EndsWith(".xsd"));

            using (Stream xsdStream = assembly.GetManifestResourceStream(xsdResourceName))
            {
                using (var xmlReader = XmlReader.Create(xsdStream))
                {
                    return XmlSchema.Read(xmlReader, null);
                }
            }
        }
    }
}
