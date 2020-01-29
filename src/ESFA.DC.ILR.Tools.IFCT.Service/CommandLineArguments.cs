using CommandLine;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class CommandLineArguments
    {
        [Option('s', "sourcefile", Required = false)]
        public string SourceFile { get; set; }

        [Option('t', "targetfile", Required = false)]
        public string TargetFile { get; set; }

        [Option('f', "sourcefolder", Required = false)]
        public string SourceFolder { get; set; }

        [Option('r', "resultfolder", Required = false)]
        public string TargetFolder { get; set; }
    }
}
