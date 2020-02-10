namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface
{
    public interface IRuleProvider
    {
        IRule<T> BuildStandardDateUplifter<T>();
    }
}
