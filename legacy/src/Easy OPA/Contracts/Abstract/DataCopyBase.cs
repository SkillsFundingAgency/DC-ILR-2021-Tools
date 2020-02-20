using EasyOPA.Constant;
using EasyOPA.Coordinator;
using EasyOPA.Indirect;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System.Composition;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// data copy base
    /// </summary>
    /// <seealso cref="ICopyDataUsing" />
    public abstract class DataCopyBase :
        ICopyDataUsing
    {
        /// <summary>
        /// Gets or sets the context (coordinator).
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the (SQL) batch (provider).
        /// </summary>
        [Import]
        public IProvideSQLBatches Batches { get; set; }

        /// <summary>
        /// Copies...
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public void Copy(IContainSessionContext usingContext, BatchOperatingYear inYear)
        {
            var batchList = Batches.GetBatch(GetBatchProcessingName(), inYear);

            Emitter.Publish(batchList.Description);

            Context.Run(batchList.Scripts, usingContext.ProcessingLocation, x => GetSupplementaryTokenReplacements(x, inYear, usingContext));

            Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
        }

        /// <summary>
        /// Gets the supplementary token replacements.
        /// </summary>
        /// <param name="onCandidate">The candidate.</param>
        /// <param name="forYear">For year.</param>
        /// <param name="usingContext">The using context.</param>
        /// <returns>
        /// a 'detokenised' script
        /// </returns>
        public string GetSupplementaryTokenReplacements(string onCandidate, BatchOperatingYear forYear, IContainSessionContext usingContext)
        {
            var target = GetTarget(usingContext);

            return Token.DoSecondaryPass(onCandidate, forYear, target, usingContext.ReturnPeriod)
                .Replace(GetTargetToken(), target.Name);
        }

        /// <summary>
        /// Gets the target token.
        /// </summary>
        /// <returns>
        /// the target token
        /// </returns>
        protected abstract string GetTargetToken();

        /// <summary>
        /// Gets the target.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <returns>returns the target connection details</returns>
        protected abstract IConnectionDetail GetTarget(IContainSessionContext usingContext);

        /// <summary>
        /// Gets the name of the batch processing.
        /// </summary>
        /// <returns>
        /// the batch processing name for that instance
        /// </returns>
        protected abstract BatchProcessName GetBatchProcessingName();
    }
}
