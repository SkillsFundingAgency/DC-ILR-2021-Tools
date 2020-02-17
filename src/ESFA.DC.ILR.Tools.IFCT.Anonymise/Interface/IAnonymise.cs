namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface
{
    public interface IAnonymise<TCurrent>
    {
        TCurrent Process(TCurrent model);
    }
}
