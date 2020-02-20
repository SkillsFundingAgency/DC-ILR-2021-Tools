using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Factory
{
    /// <summary>
    /// data exchange data store factory
    /// </summary>
    /// <seealso cref="DataStoreFactoryBase" />
    /// <seealso cref="ICreateResultsDataStores" />
    [Shared]
    [Export(typeof(ICreateResultsDataStores))]
    public sealed class ResultsDataStoreFactory :
        DataStoreFactoryBase,
        ICreateResultsDataStores
    {
        /// <summary>
        /// Store exists, a cleanse routine will be executed
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public override void StoreExists(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear)
        {
            var forTarget = usingContext.ResultsDestination;
            var batch = Batches.GetBatch(BatchProcessName.BuildResultsDataStore, inYear);

            if (!Context.StoreTableExists("Valid.Learner", forTarget))
            {
                CreateSchemaFor(
                    forTarget,
                    batch.Scripts.Skip(1).AsSafeReadOnlyList(),
                    x => Token.DoSecondaryPass(x, inYear, forTarget, usingContext.ReturnPeriod));
            }

            batch = Batches.GetBatch(BatchProcessName.CleanseResultsDataStore);

            Emitter.Publish(batch.Description);

            Context.Run(batch.Scripts, forTarget, x => Token.DoSecondaryPass(x, forProvider));
        }

        /// <summary>
        /// Builds the store.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public override void BuildStore(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear)
        {
            var batch = Batches.GetBatch(BatchProcessName.BuildResultsDataStore, inYear);

            Emitter.Publish(batch.Description);

            CreateDataStoreUsing(usingContext, batch.Scripts.First());

            var forTarget = usingContext.ResultsDestination;

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
            return inContext.ResultsDestination.Name;
        }
    }
}
