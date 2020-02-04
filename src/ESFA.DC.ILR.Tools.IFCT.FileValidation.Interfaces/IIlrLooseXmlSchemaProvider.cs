using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IIlrLooseXmlSchemaProvider
    {
        XmlSchema Provide();
    }
}