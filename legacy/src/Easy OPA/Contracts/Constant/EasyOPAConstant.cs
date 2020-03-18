namespace EasyOPA.Constant
{
    public struct EasyOPAConstant
    {
        /// <summary>
        /// The (general) location of the resource  strings; used for the resource manager
        /// </summary>
        public const string ResourceLocation = "EasyOPA.Properties.Resources";

        /// <summary>
        /// The transformation file extension
        /// </summary>
        public const string TransformationFileExtension = ".xsl";

        /// <summary>
        /// The transformation file search pattern
        /// </summary>
        public const string TransformationFileSearchPattern = "*" + TransformationFileExtension;

        /// <summary>
        /// The configuration file extension
        /// </summary>
        public const string ConfigurationFileExtension = ".xml";

        /// <summary>
        /// The configuration file search pattern
        /// </summary>
        public const string ConfigurationFileSearchPattern = "*" + ConfigurationFileExtension;

        /// <summary>
        /// The script file extension
        /// </summary>
        public const string ScriptFileExtension = ".sql";

        /// <summary>
        /// The script file search pattern
        /// </summary>
        public const string ScriptFileSearchPattern = "*" + ScriptFileExtension;

        /// <summary>
        /// The zip file extension
        /// </summary>
        public const string ZipFileExtension = ".zip";

        /// <summary>
        /// The zip file search pattern
        /// </summary>
        public const string ZipFileSearchPattern = "*" + ZipFileExtension;
    }
}
