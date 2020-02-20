namespace EasyOPA.Set
{
    public enum OperationalState
    {
        /// <summary>
        /// (ready to) select configuration
        /// </summary>
        SelectConfiguration,

        /// <summary>
        /// (ready to) load input file
        /// </summary>
        LoadInputFile,

        /// <summary>
        /// (ready to) run conversion
        /// </summary>
        RunConversion
    };
}
