using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Service
{
    /// <summary>
    /// post validation input transformer
    /// </summary>
    /// <seealso cref="ITransformInputPostValidation" />
    [Shared]
    [Export(typeof(ITransformInputPostValidation))]
    public sealed class PostValidationInputTransformer :
        DataCopyBase,
        ITransformInputPostValidation
    {
        /// <summary>
        /// Transform input...
        /// </summary>
        /// <param name="usingThisContext">using this context.</param>
        /// <param name="forYear">for year.</param>
        public void TransformInput(IContainSessionContext usingThisContext, BatchOperatingYear forYear)
        {
            Copy(usingThisContext, forYear);
        }

        /// <summary>
        /// Gets the name of the batch processing.
        /// </summary>
        /// <returns>
        /// the batch processing name for that instance
        /// </returns>
        protected override BatchProcessName GetBatchProcessingName()
        {
            return BatchProcessName.TransformToValid;
        }

        /// <summary>
        /// Gets the name of the target.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <returns>
        /// the name of the target
        /// </returns>
        protected override IConnectionDetail GetTarget(IContainSessionContext usingContext)
        {
            return usingContext.ProcessingLocation;
        }

        /// <summary>
        /// Gets the target token.
        /// </summary>
        /// <returns>
        /// the target token
        /// </returns>
        protected override string GetTargetToken()
        {
            return Token.ForTargetDataStore;
        }
    }
}
