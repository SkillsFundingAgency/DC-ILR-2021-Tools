using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using Tiny.Framework;
using Tiny.Framework.Contracts;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a friendly text converter
    /// </summary>
    /// <seealso cref="IValueConverter" />
    [ValueConversion(typeof(bool), typeof(string))]
    public sealed class FriendlyTextConverter : IValueConverter
    {
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
        /// Converts a value.
        /// </summary>
        /// <param name="value">The value produced by the binding source.</param>
        /// <param name="targetType">The type of the binding target property.</param>
        /// <param name="parameter">The converter parameter to use.</param>
        /// <param name="culture">The culture to use in the converter.</param>
        /// <returns>
        /// A converted value. If the method returns null, the valid null value is used.
        /// </returns>
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var key = $"{value}Key";
            var dictionary = parameter as StringDictionary;

            if (It.Has(dictionary) && dictionary.Contains(key))
            {
                key = dictionary.GetValue(key);
            }

            if (!Cache.Holds(key))
            {
                var candidate = RunSafe.Try(() => Resources.GetString(key), () => $"resource key not found: {key}");
                Cache.Add(key, candidate);
            }

            return Cache.Fetch(key);
        }

        /// <summary>
        /// Converts a value.
        /// </summary>
        /// <param name="value">The value that is produced by the binding target.</param>
        /// <param name="targetType">The type to convert to.</param>
        /// <param name="parameter">The converter parameter to use.</param>
        /// <param name="culture">The culture to use in the converter.</param>
        /// <returns>
        /// A converted value. If the method returns null, the valid null value is used.
        /// </returns>
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return DependencyProperty.UnsetValue;
        }
    }
}