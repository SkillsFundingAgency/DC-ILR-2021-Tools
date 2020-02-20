using EasyOPA.Indirect;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// data copy base for a mapping configuration
    /// </summary>
    /// <typeparam name="TMappingConfiguration">The type of the mapping configuration.</typeparam>
    /// <seealso cref="DataCopyBase" />
    /// <seealso cref="ICloneDataUsing" />
    public abstract class DataCopyBase<TMappingConfiguration> :
        DataCopyBase,
        ICloneDataUsing
        where TMappingConfiguration : IMapClonedData
    {
        /// <summary>
        /// Gets or sets the data (cloning operations provider).
        /// </summary>
        [Import]
        public IProvideDataCloningOperations Data { get; set; }

        /// <summary>
        /// Gets or sets the mapped (entity configuration).
        /// </summary>
        [Import]
        public TMappingConfiguration Mapped { get; set; }

        /// <summary>
        /// Gets the source.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <returns>returns the source connection details</returns>
        protected abstract IConnectionDetail GetSource(IContainSessionContext usingContext);

        /// <summary>
        /// Clones...
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public void Clone(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear)
        {
            Emitter.Publish("Commencing Data Clone...");

            Data.Clone(Mapped.Entities, GetSource(usingContext), GetTarget(usingContext), forProvider);
            Copy(usingContext, inYear);
        }
    }
}
