using EasyOPA.Properties;
using EasyOPA.Set;
using EasyOPA.Utility;
using System.Collections.Generic;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// input data source, a verified source of incoming data to run through the OPA rules wrapper
    /// </summary>
    /// <seealso cref="IInputDataSource" />
    public sealed class InputDataSource :
        IInputDataSource
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="InputDataSource"/> class.
        /// </summary>
        public InputDataSource()
        {
            Providers = Collection.EmptyAndReadOnly<ILearningProvider>();
        }

        /// <summary>
        /// Gets the name.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets the type of collection.
        /// </summary>
        public TypeOfCollection CollectionType { get; set; }

        /// <summary>
        /// Gets the operating year.
        /// </summary>
        public BatchOperatingYear OperatingYear { get; set; }

        /// <summary>
        /// Gets a value indicating whether this instance is multi provider source.
        /// </summary>
        public bool IsMultiProviderSource => It.IsInRange(Providers.Count, 2, int.MaxValue);

        /// <summary>
        /// Gets the type of the provider.
        /// </summary>
        public string ProviderType => IsMultiProviderSource ? Resources.MultiProvider : Resources.SingleProvider;

        /// <summary>
        /// Gets the providers.
        /// </summary>
        public IReadOnlyCollection<ILearningProvider> Providers { get; set; }

        /// <summary>
        /// Gets the source container.
        /// </summary>
        public string Container { get; set; }

        public string DBUser { get; set; }

        public string DBPassword { get; set; }
        /// <summary>
        /// Gets the providers.
        /// </summary>
        IReadOnlyCollection<ILearningProvider> IInputDataSource.Providers => Providers;

        /// <summary>
        /// Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <returns>
        /// A <see cref="string" /> that represents this instance.
        /// </returns>
        public override string ToString()
        {
            return $"{Name} ({CollectionType}, {ProviderType}, {OperatingYear.AsString()})";
        }
    }
}
