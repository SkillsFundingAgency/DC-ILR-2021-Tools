using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Model;
using System.Composition;
using EasyOPA.Set;
using EasyOPA.Provider;

namespace EasyOPA.Service
{
    /// <summary>
    /// The source data copier
    /// </summary>
    /// <seealso cref="DataCopyBase" />
    /// <seealso cref="ICopySourceData" />
    [Shared]
    [Export(typeof(ICopySourceData))]
    public sealed class SourceDataCopier :
        DataCopyBase<IProvideCloneInputConfiguration>,
        ICopySourceData
    {
        /// <summary>
        /// Gets the source.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <returns>
        /// returns the source connection details
        /// </returns>
        protected override IConnectionDetail GetSource(IContainSessionContext usingContext)
        {
            return usingContext.SourceLocation;
        }

        /// <summary>
        /// Gets the target.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <returns>
        /// returns the target connection details
        /// </returns>
        protected override IConnectionDetail GetTarget(IContainSessionContext usingContext)
        {
            return usingContext.ProcessingLocation;
        }

        /// <summary>
        /// Gets the target token.
        /// </summary>
        /// <returns>the target token</returns>
        protected override string GetTargetToken()
        {
            return Token.ForSourceDataStore;
        }

        /// <summary>
        /// Gets the name of the batch processing.
        /// </summary>
        /// <returns>
        /// the batch processing name for that instance
        /// </returns>
        protected override BatchProcessName GetBatchProcessingName()
        {
            return BatchProcessName.CopyToProcessingDataStore;
        }
    }
}
