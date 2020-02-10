namespace ESFA.DC.ILR.Tools.IFCT.Interface
{
    public interface IMap<in TPrevious, out TCurrent>
    {
        TCurrent Map(TPrevious model);
    }
}
