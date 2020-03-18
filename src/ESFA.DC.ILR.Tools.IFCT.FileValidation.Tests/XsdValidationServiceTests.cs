using System.Xml;
using System.Xml.Schema;
using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Tests
{
    public class XsdValidationServiceTests
    {
        [Fact]
        public void BuildXmlReaderSettings()
        {
            var xmlSchemaSet = new XmlSchemaSet();

            var xmlReaderSettings = XsdValidationService.BuildReaderSettings(xmlSchemaSet);

            xmlReaderSettings.CloseInput.Should().BeFalse();
            xmlReaderSettings.ValidationType.Should().Be(ValidationType.Schema);
            xmlReaderSettings.Schemas.Should().Be(xmlSchemaSet);
            xmlReaderSettings.ValidationFlags.Should().Be(XmlSchemaValidationFlags.ProcessIdentityConstraints);
        }

        [Fact]
        public void BuildXmlNsReaderSettings()
        {
            var schemaSet = new XmlSchemaSet();

            var xmlReaderSettings = XsdValidationService.BuildXmlNsReaderSettings(schemaSet);

            xmlReaderSettings.CloseInput.Should().BeFalse();
            xmlReaderSettings.ValidationType.Should().Be(ValidationType.Schema);
            xmlReaderSettings.Schemas.Should().Be(schemaSet);
            xmlReaderSettings.ValidationFlags.Should().Be(XmlSchemaValidationFlags.ProcessIdentityConstraints | XmlSchemaValidationFlags.ReportValidationWarnings);
        }
    }
}
