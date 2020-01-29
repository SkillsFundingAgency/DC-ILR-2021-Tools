using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public class FileConversionContext : IFileConversionContext
    {
        public string SourceFile { get; set; }

        public string TargetFile { get; set; }

        public string SourceFolder { get; set; }

        public string TargetFolder { get; set; }
    }
}
