using EasyOPA.Indirect;
using EasyOPA.Model;
using EasyOPA.Set;
using System.Threading.Tasks;

namespace EasyOPA.Manager
{
    /// <summary>
    /// i manage assets
    /// </summary>
    public interface IManageAssets :
        IRequireComposing
    {
        /// <summary>
        /// Gets the folder names.
        /// </summary>
        IContainFolderNames FolderNames { get; }

        /// <summary>
        /// Gets the locations.
        /// </summary>
        IContainLocations Locations { get; }

        /// <summary>
        /// Gets the name of the instance.
        /// </summary>
        string InstanceName { get; }

        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        int TimeoutInMinutes { get; }

        /// <summary>
        /// Gets the connection timeout.
        /// </summary>
        int ConnectionTimeout { get; }

        /// <summary>
        /// Gets the content of the asset.
        /// the file location is a partial path completed by the use of the ESFA  "asset location"
        /// </summary>
        /// <param name="usingPartialPath">using this partial path</param>
        /// <returns>a files content from the asset path</returns>
        Task<string> GetContent(string usingPartialPath);

        /// <summary>
        /// Sets the name of the instance.
        /// </summary>
        /// <param name="newInstanceName">New name of the instance.</param>
        void SetInstanceName(string newInstanceName);

        /// <summary>
        /// Sets the timeout in minutes.
        /// </summary>
        /// <param name="newTimeout">The new timeout.</param>
        void SetTimeoutInMinutes(int newTimeout);

        /// <summary>
        /// Gets the current run facility.
        /// </summary>
        TypeOfRunMode Current { get; }

        /// <summary>
        /// Sets the run mode.
        /// </summary>
        /// <param name="isLite">if set to <c>true</c> [is lite].</param>
        void SetRunMode(bool isLite);

        /// <summary>
        /// Gets the run mode.
        /// </summary>
        /// <returns>the current run mode</returns>
        IContainRunModeDetail GetRunMode();
    }
}
