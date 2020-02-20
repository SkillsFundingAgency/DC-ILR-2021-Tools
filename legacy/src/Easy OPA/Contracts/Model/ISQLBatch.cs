using EasyOPA.Set;
using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i sql batch
    /// </summary>
    public interface ISQLBatch
    {
        /// <summary>
        /// Gets the description.
        /// </summary>
        string Description { get; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        BatchProcessName Name { get; }

        /// <summary>
        /// Gets the operating year.
        /// </summary>
        BatchOperatingYear OperatingYear { get; }

        /// <summary>
        /// Gets the scripts.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> Scripts { get; }
    }
}
