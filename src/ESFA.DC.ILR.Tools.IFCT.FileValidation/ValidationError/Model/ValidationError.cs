using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces.Enum;
using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.ValidationError.Model
{
    public class ValidationError : IValidationError
    {
        public ValidationError()
        {
        }

        public ValidationError(string ruleName, string learnerReferenceNumber = null, long? aimSequenceNumber = null, Severity? severity = null, IEnumerable<IErrorMessageParameter> errorMessageParameters = null)
        {
            LearnerReferenceNumber = learnerReferenceNumber;
            AimSequenceNumber = aimSequenceNumber;
            RuleName = ruleName;
            Severity = severity;
            ErrorMessageParameters = errorMessageParameters;
        }

        public string LearnerReferenceNumber { get; set; }
        public long? AimSequenceNumber { get; set; }
        public string RuleName { get; set; }
        public Severity? Severity { get; set; }
        public IEnumerable<IErrorMessageParameter> ErrorMessageParameters { get; set; }
    }
}
