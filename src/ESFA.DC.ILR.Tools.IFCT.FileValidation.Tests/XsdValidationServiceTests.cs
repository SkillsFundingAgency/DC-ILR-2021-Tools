using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using Moq;
using System.Xml.Schema;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Tests
{
    public class XsdValidationServiceTests
    {
       
        private XsdValidationService NewService(IXmlSchemaProvider xmlSchemaProvider = null)
        {
            return new XsdValidationService();
        }
    }
}
