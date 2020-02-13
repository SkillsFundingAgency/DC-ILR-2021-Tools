namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface
{
    public interface IUplifter<T>
    {
        T Process(T model);
    }
}
