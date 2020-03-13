using EasyOPA.Set;
using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// input data source model item contract
    /// </summary>
    public interface IInputDataSource
    {
        /// <summary>
        /// Gets the name.
        /// </summary>
        string Name { get; }

        /// <summary>
        /// Gets the (source) container.
        /// </summary>
        string Container { get; }

        string DBUser { get; }

        string DBPassword { get; }

        /// <summary>
        /// Gets the type of collection.
        /// </summary>
        TypeOfCollection CollectionType { get; }

        /// <summary>
        /// Gets the operating year.
        /// </summary>
        BatchOperatingYear OperatingYear { get; }

        /// <summary>
        /// Gets a value indicating whether this instance is multi provider source.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is multi provider source; otherwise, <c>false</c>.
        /// </value>
        bool IsMultiProviderSource { get; }

        /// <summary>
        /// Gets the providers.
        /// </summary>
        IReadOnlyCollection<ILearningProvider> Providers { get; }
    }
}
