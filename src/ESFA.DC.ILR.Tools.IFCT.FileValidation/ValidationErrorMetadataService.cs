using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation
{
    public class ValidationErrorMetadataService : IValidationErrorMetadataService
    {
        public bool IsSchemaValid(IEnumerable<IValidationError> validationErrors) => validationErrors.All(ve => ve.RuleName != ValidationErrorHandler.SchemaRuleName);
    }
}