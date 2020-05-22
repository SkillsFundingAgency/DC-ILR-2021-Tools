namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface
{
    public interface IReferenceProvider<T>
    {
        T ProvideNewReference(T prevValue, bool failIfMissing = false);
    }
}