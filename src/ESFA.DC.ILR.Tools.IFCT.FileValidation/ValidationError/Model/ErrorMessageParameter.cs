using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation.ValidationError.Model
{
    public class ErrorMessageParameter : IErrorMessageParameter
    {
        public ErrorMessageParameter()
        {
        }

        public ErrorMessageParameter(string propertyName, string value)
        {
            PropertyName = propertyName;
            Value = value;
        }

        public string PropertyName { get; set; }
        public string Value { get; set; }
    }
}
