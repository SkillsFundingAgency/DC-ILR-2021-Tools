using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IValidationErrorHandler
    {
        void XsdNsValidationErrorHandler(object sender, ValidationEventArgs e);
        void XsdValidationErrorHandler(object sender, ValidationEventArgs e);
    }
}
