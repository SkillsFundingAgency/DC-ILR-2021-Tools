using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i map cloned entity details
    /// </summary>
    public interface IMapCloneEntityDetails
    {
        /// <summary>
        /// Gets the master (source)
        /// </summary>
        string Master { get; }

        /// <summary>
        /// Gets the target (destination)
        /// </summary>
        string Target { get; }

        /// <summary>
        /// Gets the attributes.
        /// </summary>
        IReadOnlyCollection<IMapCloneAttributeDetails> Attributes { get; }
    }
}
