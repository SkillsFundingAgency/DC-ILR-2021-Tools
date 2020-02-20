using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a null value converter
    /// </summary>
    /// <seealso cref="IValueConverter" />
    [ValueConversion(typeof(bool), typeof(object))]
    public sealed class IsNullConverter : IValueConverter
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="IsNullConverter"/> class.
        /// </summary>
        public IsNullConverter()
        {
            IsInverted = false;
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is inverted.
        /// </summary>
        /// <value>
        /// <c>true</c> if this instance is inverted; otherwise, <c>false</c>.
        /// </value>
        public bool IsInverted { get; set; }

        /// <summary>
        /// Converts the specified value.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="targetType">Type of the target.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns>the result</returns>
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return IsInverted ? value != null : value == null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return DependencyProperty.UnsetValue;
        }
    }
}