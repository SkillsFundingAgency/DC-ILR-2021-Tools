using EasyOPA.Manager;
using EasyOPA.Model;
using ESFA.Common.Abstract;
using ESFA.Common.Service;
using System.Composition;
using System.IO;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// the file serialization service base abstract
    /// this class will undergo repeated loads as the required configuration changes
    /// </summary>
    /// <typeparam name="TConcrete">The type of the file content.</typeparam>
    /// <typeparam name="TContract">The type of the file contract.</typeparam>
    /// <seealso cref="ISerializeToFile{TFileContract}" />
    public abstract class SpecialisedFileConfigurationHostBase<TConcrete, TContract> :
        SerializeToFileBase<TConcrete, TContract>,
        ISerializeToFile<TContract>,
        IHandleMessage<IUseExperimentalItemsMessage>,
        IHandleMessage<IChangeRunModeMessage>
            where TConcrete : class, TContract, new()
            where TContract : class
    {
        /// <summary>
        /// The configuration filename
        /// </summary>
        protected abstract string ConfigurationFilename { get; }

        /// <summary>
        /// Gets a value indicating whether this instance uses experimental items.
        /// </summary>
        public bool UseExperimental { get; private set; }

        /// <summary>
        /// Gets or sets the action synchronise(r).
        /// </summary>
        [Import]
        public ISynchroniseActions Synchronise { get; set; }

        /// <summary>
        /// Gets or sets the asset (manager).
        /// </summary>
        [Import]
        public IManageAssets Asset { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// this property will require the composition import decorator
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the console.
        /// </summary>
        [Import]
        public IEmitToConsole Console { get; set; }

        /// <summary>
        /// Composes this instance.
        /// </summary>
        [OnImportsSatisfied] // <= required, but may result in double initialisation...
        public void Compose()
        {
            Asset.Compose();
            RegisterMessageHandler();
            Configure();
        }

        /// <summary>
        /// Configures this instance.
        /// </summary>
        public void Configure()
        {
            // not sure on this, but i consider it (the load) a critical section
            while (!Synchronise.Start())
            {
                Synchronise.WaitTillReady();
            }

            var loadPath = GetLoadPath();
            if (loadPath.Contains("ILRTableMappings"))
            {
                loadPath = GetLoadPath();
            }
            if (!File.Exists(loadPath))
            {
                Console.Publish($"File not found: {loadPath}");
                Synchronise.Finish();
                return;
            }

            // TODO: fix this, not the right method of flow control, but stops the auto reset holding up the load if we get a de-serialisation error
            SafeActions.Try(() =>
            {
                Initialise(loadPath);
                PerformHealthCheck();
                PerformSupplmentalLoad(Configured as TConcrete);
            });

            Synchronise.Finish();
        }

        /// <summary>
        /// Gets or sets the configured pseudonyms list
        /// </summary>
        public TContract Configured { get; set; }

        /// <summary>
        /// Initialises this instance.
        /// </summary>
        public void Initialise(string loadPath)
        {
            Configured = Load(loadPath);
        }

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>the path to the configuration file</returns>
        public abstract string GetLoadPath();

        /// <summary>
        /// Performs the health check.
        /// </summary>
        public abstract void PerformHealthCheck();

        /// <summary>
        /// Changes the run mode.
        /// </summary>
        public abstract void ChangeRunMode();

        /// <summary>
        /// Perform supplmental load.
        /// Once the intial load is conducted and a health check
        /// performed, we can do some supplemental stuff...
        /// </summary>
        /// <param name="onConcretion">on concretion.</param>
        public abstract void PerformSupplmentalLoad(TConcrete onConcretion);

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public virtual void RegisterMessageHandler()
        {
            Mediator.Register<IUseExperimentalItemsMessage>(HandleMessage);
            Mediator.Register<IChangeRunModeMessage>(HandleMessage);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IUseExperimentalItemsMessage message)
        {
            UseExperimental = message.Payload;
            Configure();
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IChangeRunModeMessage message)
        {
            ChangeRunMode();
        }
    }
}
