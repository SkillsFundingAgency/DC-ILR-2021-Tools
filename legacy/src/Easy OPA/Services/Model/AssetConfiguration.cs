using EasyOPA.Set;
using ESFA.Common;
using ESFA.Common.Model;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// asset configuration is the instantiation of the xml file "assetmanagement.cfg"
    /// </summary>
    /// <seealso cref="IContainAssetConfiguration" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class AssetConfiguration :
        IContainAssetConfiguration
    {
        /// <summary>
        /// The default timeout
        /// </summary>
        public const int DefaultTimeout = 10; // minutes

        /// <summary>
        /// Gets the associated locations.
        /// </summary>
        [DataMember]
        public LocationsContainer Locations { get; set; }

        /// <summary>
        /// Gets the folder names.
        /// </summary>
        [DataMember]
        public FolderNamesContainer FolderNames { get; set; }

        [DataMember]
        public string DBName { get; set; }

        [DataMember]
        public string DBUser { get; set; }

        [DataMember]
        public string DBPassword { get; set; }

        /// <summary>
        /// Gets the name of the instance.
        /// </summary>
        [DataMember]
        public string InstanceName { get; set; }

        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        [DataMember]
        public int? TimeoutInMinutes { get; set; }

        /// <summary>
        /// Gets the default (run facility).
        /// </summary>
        [DataMember]
        public TypeOfRunMode DefaultRunMode { get; set; }

        /// <summary>
        /// Gets the (full set of run) facilities.
        /// </summary>
        [DataMember]
        public CleanList<RunModeContainer> RunModes { get; set; }

        /// <summary>
        /// Gets the (full set of run) facilities.
        /// </summary>
        IReadOnlyCollection<IContainRunModeDetail> IContainAssetConfiguration.RunModes => RunModes;

        /// <summary>
        /// Gets the associated locations.
        /// </summary>
        IContainLocations IContainAssetConfiguration.Locations => Locations;

        /// <summary>
        /// Gets the folder names.
        /// </summary>
        IContainFolderNames IContainAssetConfiguration.FolderNames => FolderNames;

        /// <summary>
        /// Gets the name of the instance.
        /// </summary>
        string IContainAssetConfiguration.InstanceName => InstanceName ?? Environment.MachineName;

        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        int IContainAssetConfiguration.TimeoutInMinutes => GetTimeoutInMinutes();

        /// <summary>
        /// Gets the connection timeout.
        /// </summary>
        int IContainAssetConfiguration.ConnectionTimeout => GetTimeoutInMinutes() * 60;

        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        /// <returns></returns>
        private int GetTimeoutInMinutes() => TimeoutInMinutes ?? DefaultTimeout;

        /// <summary>
        /// Sets the connection timeout.
        /// </summary>
        /// <param name="newTimeout">The new timeout.</param>
        public void SetTimeoutInMinutes(int newTimeout)
        {
            TimeoutInMinutes = newTimeout;
        }

        /// <summary>
        /// Sets the name of the instance.
        /// </summary>
        /// <param name="newInstanceName">New name of the instance.</param>
        public void SetInstanceName(string newInstanceName)
        {
            InstanceName = newInstanceName;
        }

        /// <summary>
        /// Sets the default run mode.
        /// </summary>
        /// <param name="newRunMode">The new run mode.</param>
        public void SetDefaultRunMode(TypeOfRunMode newRunMode)
        {
            DefaultRunMode = newRunMode;
        }
    }
}
