using System.IO;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IXsdValidationService
    {
        void Validate(Stream stream);
    }
}
