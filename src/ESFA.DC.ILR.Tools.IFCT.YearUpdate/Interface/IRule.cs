namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface
{
    public interface IRule<T>
    {
        T Definition(T values);
    }
}
