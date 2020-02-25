namespace ESFA.DC.ILR.Tools.IFCT.Console
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var conversionClass = new ConversionClass();
            conversionClass.ConvertFile(args);
        }
    }
}
