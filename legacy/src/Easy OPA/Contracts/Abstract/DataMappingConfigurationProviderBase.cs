using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace EasyOPA.Abstract
{
    public abstract class DataMappingConfigurationProviderBase<TCloneDataMap> :
        SpecialisedFileConfigurationHostBase<TCloneDataMap, IMapClonedData>,
        IHandleMessage<IChangeOperatingYearMessage>
        where TCloneDataMap : class, IMapClonedData, new()
    {
        /// <summary>
        /// The operating year
        /// </summary>
        private BatchOperatingYear _operatingYear;

        /// <summary>
        /// Gets the specialised asset location.
        /// </summary>
        private string _specialisedAssetLocation => Path.Combine(Location.OfAssets, _operatingYear.AsString());

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>
        /// the path to the configuration file
        /// </returns>
        public override string GetLoadPath()
        {
            return Path.Combine(_specialisedAssetLocation, ConfigurationFilename);
        }

        /// <summary>
        /// Performs the health check.
        /// </summary>
        public override void PerformHealthCheck()
        {
            // health check on load
            It.IsEmpty(Configured.Entities)
                .AsGuard<ArgumentNullException>(nameof(Configured.Entities));

            Configured.Entities.ForEach(tableMap =>
            {
                It.IsEmpty(tableMap.Master)
                    .AsGuard<ArgumentException>($"master not set on tablemap {tableMap.Master}");
                It.IsEmpty(tableMap.Target)
                    .AsGuard<ArgumentException>($"target not set on tablemap {tableMap.Target}");

                It.IsEmpty(tableMap.Attributes)
                    .AsGuard<ArgumentNullException>($"no column mappings for master table '{tableMap.Master}'");

                tableMap.Attributes
                    .ForEach(columnMap =>
                    {
                        It.IsEmpty(columnMap.Master)
                            .AsGuard<ArgumentException>($"master not set on column map '{columnMap.Master}'");
                        It.IsEmpty(columnMap.Target)
                            .AsGuard<ArgumentException>($"target not set on column map '{columnMap.Target}'");
                    });
            });
        }

        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        public IReadOnlyCollection<IMapCloneEntityDetails> Entities => Configured.Entities;

        /// <summary>
        /// Changes the run mode.
        /// </summary>
        public override void ChangeRunMode()
        {
            if (_operatingYear == BatchOperatingYear.NotSet)
            {
                return;
            }

            Configure();
        }

        /// <summary>
        /// Perform supplmental load.
        /// Once the intial load is conducted and a health check
        /// performed, we can do some supplemental stuff...
        /// </summary>
        /// <param name="onConcretion">on concretion.</param>
        public override void PerformSupplmentalLoad(TCloneDataMap onConcretion)
        {
            // nothing to do, here...
            // a standard load is performed after changing the file path
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public override void RegisterMessageHandler()
        {
            base.RegisterMessageHandler();
            Mediator.Register<IChangeOperatingYearMessage>(HandleMessage);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IChangeOperatingYearMessage message)
        {
            _operatingYear = message.Payload.Year;
            Configure();
        }
    }
}
