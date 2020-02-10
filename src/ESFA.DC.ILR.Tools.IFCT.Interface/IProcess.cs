namespace ESFA.DC.ILR.Tools.IFCT.Interface
{
    public interface IProcess<TCurrent>
    {
        TCurrent Process(TCurrent model);
    }
}
