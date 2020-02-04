using System.IO;
using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IXsdValidationService
    {
        void Validate(Stream stream, XmlSchemaSet xmlSchemaSet);
    }
}
