using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i map clone data (configuration)
    /// the contract for input and output data mappings
    /// </summary>
    public interface IMapClonedData
    {
        /// <summary>
        /// Gets the table mappings.
        /// </summary>
        IReadOnlyCollection<IMapCloneEntityDetails> Entities { get; }
    }
}
