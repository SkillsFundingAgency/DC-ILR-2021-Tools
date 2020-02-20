using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i contain sql batches
    /// </summary>
    public interface IContainSQLBatches
    {
        /// <summary>
        /// Gets the batches.
        /// </summary>
        IReadOnlyCollection<ISQLBatch> Batches { get; }
    }
}
