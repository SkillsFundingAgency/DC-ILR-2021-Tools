using CommandLine;

namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public class CommandLineArguments
    {
        [Option('s', "sourcefile", Required = true)]
        public string SourceFile { get; set; }

        [Option('t', "targetfile", Required = true)]
        public string TargetFile { get; set; }
    }
}
