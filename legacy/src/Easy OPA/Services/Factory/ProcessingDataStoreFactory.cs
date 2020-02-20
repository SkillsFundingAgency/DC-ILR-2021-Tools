using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Model;
using EasyOPA.Set;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Factory
{
    /// <summary>
    /// The intrajob data store factory
    /// </summary>
    /// <seealso cref="DataStoreFactoryBase" />
    /// <seealso cref="ICreateProcessingDataStores" />
    [Shared]
    [Export(typeof(ICreateProcessingDataStores))]
    public sealed class ProcessingDataStoreFactory :
        DataStoreFactoryBase,
        ICreateProcessingDataStores
    {
        /// <summary>
        /// Store exists, a cleanse routine will be executed
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public override void StoreExists(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear)
        {
            var batch = Batches.GetBatch(BatchProcessName.CleanseProcessingDataStore, inYear);

            Emitter.Publish(batch.Description);

            Context.Run(batch.Scripts, usingContext.ProcessingLocation, x => Token.DoSecondaryPass(x, forProvider));
        }

        /// <summary>
        /// Builds the store.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public override void BuildStore(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear)
        {
            var batch = Batches.GetBatch(BatchProcessName.BuildProcessingDataStore, inYear);

            Emitter.Publish(batch.Description);

            var forTarget = usingContext.ProcessingLocation;

            CreateDataStoreUsing(usingContext, batch.Scripts.First());
            CreateSchemaFor(
                forTarget,
                batch.Scripts.Skip(1).AsSafeReadOnlyList(),
                x => Token.DoSecondaryPass(x, inYear, forTarget, usingContext.ReturnPeriod));
        }

        /// <summary>
        /// Gets the name of the store for...
        /// </summary>
        /// <param name="inContext">in context.</param>
        /// <returns>
        /// the name of the required data store
        /// </returns>
        public override string GetStoreNameFor(IContainSessionContext inContext)
        {
            return inContext.ProcessingLocation.Name;
        }
    }
}
