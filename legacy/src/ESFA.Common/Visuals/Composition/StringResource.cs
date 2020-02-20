using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Windows.Markup;
using Tiny.Framework;
using Tiny.Framework.Contracts;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a markup extension class to resolve localised resource strings
    /// </summary>
    /// <seealso cref="MarkupExtension" />
    public sealed class StringResource : MarkupExtension
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="StringResource"/> class.
        /// </summary>
        /// <param name="resourceKey">The resource key.</param>
        public StringResource(string resourceKey)
        {
            ResourceKey = resourceKey;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="StringResource"/> class.
        /// </summary>
        /// <param name="resourceKey">The resource key.</param>
        /// <param name="stringFormat">The string format.</param>
        public StringResource(string resourceKey, string stringFormat)
            : this(resourceKey)
        {
            StringFormat = stringFormat;
        }

        /// <summary>
        /// Gets or sets the resource key.
        /// </summary>
        [ConstructorArgument("ResourceKey")]
        public string ResourceKey { get; set; }

        /// <summary>
        /// Gets or sets the string format.
        /// </summary>
        [ConstructorArgument("StringFormat")]
        public string StringFormat { get; set; }

        // Let me offer my apologies now...
        private IResolveResources _resources;

        /// <summary>
        /// Gets the resources.
        /// </summary>
        private IResolveResources Resources => _resources
            ?? (_resources = MEFContainer.Resolve<IResolveResources>());

        // Let me offer my apologies now, here too...
        private IProvideStringResourceCache _cache;

        /// <summary>
        /// Gets the resources.
        /// </summary>
        private IProvideStringResourceCache Cache => _cache
            ?? (_cache = MEFContainer.Resolve<IProvideStringResourceCache>());

        /// <summary>
        /// Provides the value.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        /// <returns>the 'string'</returns>
        public override object ProvideValue(IServiceProvider serviceProvider)
        {
            // TODO: review this, it's not right but works in the designer...
            var candidate = string.Empty;
            try
            {
                if (!Cache.Holds(ResourceKey))
                {
                    candidate = RunSafe.Try(() => Resources.GetString(ResourceKey), () => $"resource key not found: {ResourceKey}");
                    Cache.Add(ResourceKey, candidate);
                }

                candidate = Cache.Fetch(ResourceKey);

                if (It.Has(StringFormat))
                {
                    candidate = Format.String(StringFormat, candidate);
                }

                return candidate;
            }
            catch
            {
                return null;
            }
        }
    }
}
