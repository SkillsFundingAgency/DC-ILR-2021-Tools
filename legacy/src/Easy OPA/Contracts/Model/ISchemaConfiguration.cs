using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i schema configuration
    /// </summary>
    public interface ISchemaConfiguration
    {
        /// <summary>
        /// Gets the maps.
        /// </summary>
        IReadOnlyCollection<ISchemaMap> Maps { get; }
    }
}
