using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IValidationErrorMetadataService
    {
        bool IsSchemaValid(IEnumerable<IValidationError> validationErrors);
    }
}
