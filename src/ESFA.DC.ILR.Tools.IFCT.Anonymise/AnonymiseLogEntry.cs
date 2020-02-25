using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class AnonymiseLogEntry : IAnonymiseLogEntry
    {
        public string FieldName { get; set; }

        public string OldValue { get; set; }

        public string NewValue { get; set; }
    }
}
