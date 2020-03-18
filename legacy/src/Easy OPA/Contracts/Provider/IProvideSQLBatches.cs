using EasyOPA.Indirect;
using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide sql batches
    /// </summary>
    public interface IProvideSQLBatches :
        IRequireComposing
    {
        /// <summary>
        /// Gets the batch.
        /// </summary>
        /// <param name="byName">by Name</param>
        /// <param name="andYear">and year.</param>
        /// <returns>
        /// a batch detail
        /// </returns>
        ISQLBatch GetBatch(BatchProcessName byName, BatchOperatingYear andYear = BatchOperatingYear.All);
    }
}
