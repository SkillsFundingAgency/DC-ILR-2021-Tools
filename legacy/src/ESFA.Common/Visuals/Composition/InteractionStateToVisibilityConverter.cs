using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// the boolean to visibility converter
    /// </summary>
    /// <seealso cref="IValueConverter" />
    [ValueConversion(typeof(int), typeof(Visibility))]
    public sealed class InteractionStateToVisibilityConverter : IValueConverter
    {
        /// <summary>
        /// Gets or sets a value indicating whether this instance is inverted.
        /// </summary>
        public bool IsInverted { get; set; }

        /// <summary>
        /// Converts the specified value.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="targetType">Type of the target.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns></returns>
        /// <exception cref="ArgumentException">parameter not supported</exception>
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            It.IsNull(parameter)
                .AsGuard<ArgumentException>("converter parameter cannot be null");

            var requiredState = (int)parameter;
            var existingState = (int)value;

            var result = IsInverted
                ? existingState != requiredState
                : existingState == requiredState;

            return result ? Visibility.Visible : Visibility.Hidden;
        }

        /// <summary>
        /// Converts the back.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="targetType">Type of the target.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns><see cref="DependencyProperty.UnsetValue"/></returns>
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return DependencyProperty.UnsetValue;
        }
    }
}