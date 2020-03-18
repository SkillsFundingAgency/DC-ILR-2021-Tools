using System.Xml.Schema;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IValidationErrorHandler
    {
        bool ErrorRaised { get; set; }

        void XsdNsValidationErrorHandler(object sender, ValidationEventArgs e);

        void XsdValidationErrorHandler(object sender, ValidationEventArgs e);
    }
}
