namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IMap<in TPrevious, out TCurrent>
    {
        TCurrent Map(TPrevious model);
    }
}
