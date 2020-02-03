using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces.Enum;
using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces
{
    public interface IValidationError
    {
        string LearnerReferenceNumber { get; }

        long? AimSequenceNumber { get; }

        string RuleName { get; }

        Severity? Severity { get; }

        IEnumerable<IErrorMessageParameter> ErrorMessageParameters { get; }
    }
}
