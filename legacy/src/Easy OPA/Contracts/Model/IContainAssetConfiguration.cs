using EasyOPA.Set;
using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i contain asset configuration
    /// </summary>
    public interface IContainAssetConfiguration
    {
        /// <summary>
        /// Gets the associated locations.
        /// </summary>
        IContainLocations Locations { get; }

        /// <summary>
        /// Gets the folder names.
        /// </summary>
        IContainFolderNames FolderNames { get; }

        /// <summary>
        /// Gets the name of the instance.
        /// </summary>
        string InstanceName { get; }

        string DBUser { get; }

        string DBPassword { get; }
        
        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        int TimeoutInMinutes { get; }

        /// <summary>
        /// Gets the connection timeout.
        /// </summary>
        int ConnectionTimeout { get; }

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
        /// Gets the default (run facility).
        /// </summary>
        TypeOfRunMode DefaultRunMode { get; }

        /// <summary>
        /// Gets the (full set of) run modes.
        /// </summary>
        IReadOnlyCollection<IContainRunModeDetail> RunModes { get; }

        /// <summary>
        /// Sets the default run mode.
        /// </summary>
        /// <param name="newRunMode">The new run mode.</param>
        void SetDefaultRunMode(TypeOfRunMode newRunMode);
    }
}
