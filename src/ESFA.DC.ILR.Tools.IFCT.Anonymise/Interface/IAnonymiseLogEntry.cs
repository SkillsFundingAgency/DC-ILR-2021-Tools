namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface
{
    public interface IAnonymiseLogEntry
    {
        string FieldName { get; set; }
        string OldValue { get; set; }
        string NewValue { get; set; }
    }
}
