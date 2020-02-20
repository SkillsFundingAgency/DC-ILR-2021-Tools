using ESFA.Common.Service;
using System.Composition;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Abstract
{
    /// <summary>
    /// the file serialization service base abstract
    /// </summary>
    /// <typeparam name="TConcrete">The type of the file content.</typeparam>
    /// <typeparam name="TContract">The type of the file contract.</typeparam>
    /// <seealso cref="ISerializeToFile{TFileContract}" />
    public abstract class FileConfigurationHostBase<TConcrete, TContract> :
        SerializeToFileBase<TConcrete, TContract>,
        ISerializeToFile<TContract>
        where TConcrete : class, TContract, new()
        where TContract : class
    {
        private bool _initialised;

        /// <summary>
        /// Gets or sets the action synchronise(r).
        /// </summary>
        [Import]
        public ISynchroniseActions Synchronise { get; set; }

        /// <summary>
        /// Composes this instance.
        /// </summary>
        [OnImportsSatisfied] // <= required, but may result in double initialisation...
        public void Compose()
        {
            // not sure on this, but i consider it (the load) a critical section
            while (!Synchronise.Start())
            {
                Synchronise.WaitTillReady();
            }

            if (_initialised)
            {
                Synchronise.Finish();
                return;
            }

            _initialised = true;
            Initialise();
            PerformHealthCheck();

            Synchronise.Finish();
        }

        /// <summary>
        /// Gets or sets the configured pseudonyms list
        /// </summary>
        public TContract Configured { get; set; }

        /// <summary>
        /// Initialises this instance.
        /// </summary>
        public void Initialise()
        {
            Configured = Load(GetLoadPath());
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
    }
}
