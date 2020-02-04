namespace ESFA.DC.ILR.Tools.IFCT.Interface
{
    public interface IProcess<in TCurrent>
    {
        bool Process(TCurrent model);
    }
}
