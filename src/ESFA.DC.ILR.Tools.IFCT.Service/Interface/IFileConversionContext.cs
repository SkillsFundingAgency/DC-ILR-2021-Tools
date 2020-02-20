namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IFileConversionContext
    {
        string SourceFile { get; }

        string SourceFolder { get; set; }

        string TargetFolder { get; }
    }
}
