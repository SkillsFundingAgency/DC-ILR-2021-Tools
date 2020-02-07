namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface
{
    public interface IUplifter<T>
    {
        T Uplift(T model);
    }
}
