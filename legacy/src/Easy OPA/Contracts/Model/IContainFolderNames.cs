namespace EasyOPA.Model
{
    /// <summary>
    /// i contain associated folder names
    /// </summary>
    public interface IContainFolderNames
    {
        /// <summary>
        /// Gets the opa configuration folder name
        /// </summary>
        string OPAConfig { get; }

        /// <summary>
        /// Gets the opa rules folder name.
        /// </summary>
        string OPARules { get; }
    }
}
