using EasyOPA.Model;
using System.Collections.Generic;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide data cloning operations
    /// </summary>
    public interface IProvideDataCloningOperations
    {
        /// <summary>
        /// Clone...
        /// </summary>
        /// <param name="usingMappings">using (table) mappings.</param>
        /// <param name="fromDataSource">from data source.</param>
        /// <param name="toDataTarget">to data target.</param>
        /// <param name="forProvider">for provider.</param>
        void Clone(IReadOnlyCollection<IMapCloneEntityDetails> usingMappings, IConnectionDetail fromDataSource, IConnectionDetail toDataTarget, int forProvider);
    }
}