using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Set;
using ESFA.Common.Abstract;
using ESFA.Common.Manager;
using ESFA.Common.Set;
using System;
using System.Composition;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Utilities;

namespace EasyOPA.Manager
{
    /// <summary>
    /// the asset manager
    /// </summary>
    /// <seealso cref="IManageAssets" />
    [Shared]
    [Export(typeof(IManageAssets))]
    public sealed class AssetManager :
        FileConfigurationHostBase<AssetConfiguration, IContainAssetConfiguration>,
        IManageAssets
    {
        /// <summary>
        /// Gets or sets the file manager.
        /// </summary>
        [Import]
        public IManageTextFiles FileManager { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the message (factory).
        /// </summary>
        [Import]
        public ICreateChangeRunModeMessages Message { get; set; }

        /// <summary>
        /// Gets the folder names.
        /// </summary>
        public IContainFolderNames FolderNames => Configured.FolderNames;

        /// <summary>
        /// Gets the locations.
        /// </summary>
        public IContainLocations Locations => Configured.Locations;

        /// <summary>
        /// Gets the name of the instance.
        /// </summary>
        public string InstanceName => Configured.InstanceName;

        public string DBUser => Configured.DBUser;

        public string DBPassword => Configured.DBPassword;
        /// <summary>
        /// Gets the connection timeout.
        /// </summary>
        public int ConnectionTimeout => Configured.ConnectionTimeout;

        /// <summary>
        /// Gets the timeout in minutes.
        /// </summary>
        public int TimeoutInMinutes => Configured.TimeoutInMinutes;

        /// <summary>
        /// Gets the current run facility.
        /// </summary>
        public TypeOfRunMode Current { get; set; }

        /// <summary>
        /// Gets the content of the asset.
        /// the file location is a partial path completed by the use of the ESFA  "asset location"
        /// </summary>
        /// <param name="usingPartialPath">using this partial path</param>
        /// <returns>
        /// a files content from the asset path
        /// </returns>
        public async Task<string> GetContent(string usingPartialPath)
        {
            var fullPath = Path.Combine(Location.OfAssets, usingPartialPath);
            return await FileManager.Load(fullPath);
        }

        /// <summary>
        /// Sets the timeout in minutes.
        /// </summary>
        /// <param name="newTimeout">The new timeout.</param>
        public void SetTimeoutInMinutes(int newTimeout)
        {
            Configured.SetTimeoutInMinutes(newTimeout);
            Save(Configured, GetLoadPath(), TypeOfMedia.XML);
        }

        /// <summary>
        /// Sets the name of the instance.
        /// </summary>
        /// <param name="newName">The new name.</param>
        public void SetInstanceName(string newName)
        {
            Configured.SetInstanceName(newName);
            Save(Configured, GetLoadPath(), TypeOfMedia.XML);
        }

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>
        /// the path to the configuration file
        /// </returns>
        public override string GetLoadPath()
        {
            return Path.Combine(Location.OfAssets, "assetmanagement.cfg");
        }

        /// <summary>
        /// Performs the health check.
        /// </summary>
        public override void PerformHealthCheck()
        {
            It.IsEmpty(Configured.FolderNames.OPAConfig)
                .AsGuard<ArgumentException>("OPA configuration location cannot be empty");
            It.IsEmpty(Configured.FolderNames.OPARules)
                .AsGuard<ArgumentException>("OPA rules location cannot be empty");
            It.IsEmpty(Configured.Locations.Experimental)
                .AsGuard<ArgumentException>("experimental folder location cannot be empty");
            It.IsEmpty(Configured.Locations.Production)
                .AsGuard<ArgumentException>("production folder location cannot be empty");

            Current = Configured.DefaultRunMode;
        }

        /// <summary>
        /// Gets the run mode.
        /// </summary>
        /// <returns>
        /// the current run mode
        /// </returns>
        public IContainRunModeDetail GetRunMode()
        {
            return Configured.RunModes.First(x => x.Name == Current);
        }

        /// <summary>
        /// Sets the run mode.
        /// </summary>
        /// <param name="isLite">if set to <c>true</c> [is lite].</param>
        public void SetRunMode(bool isLite)
        {
            Current = isLite ? TypeOfRunMode.Lite : TypeOfRunMode.Full;

            Configured.SetDefaultRunMode(Current);
            Save(Configured, GetLoadPath(), TypeOfMedia.XML);

            Mediator.Publish(Message.Create(Current));
        }
    }
}
