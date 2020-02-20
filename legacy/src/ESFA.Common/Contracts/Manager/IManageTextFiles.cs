using System.Threading.Tasks;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// i manage text files
    /// </summary>
    public interface IManageTextFiles
    {
        /// <summary>
        /// Loads the specified file (name).
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <returns>the content of the file as a string</returns>
        Task<string> Load(string fileName);

        /// <summary>
        /// Saves the specified file (name).
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="content">The (file) content.</param>
        /// <returns></returns>
        Task Save(string fileName, string content);

        /// <summary>
        /// Moves the file.
        /// </summary>
        /// <param name="fromHere">From here.</param>
        /// <param name="toHere">To here.</param>
        /// <returns></returns>
        Task MoveFile(string fromHere, string toHere);

        /// <summary>
        /// Creates the operating folder.
        /// </summary>
        /// <param name="rootDesktopName">Name of the root desktop.</param>
        /// <param name="otherFolders">The other folders.</param>
        /// <returns>the name of the operating folder</returns>
        Task<string> CreateOperatingFolder(string rootDesktopName, params string[] otherFolders);
    }
}
