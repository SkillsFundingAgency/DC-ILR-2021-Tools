using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// the boolean to visibility converter
    /// </summary>
    /// <seealso cref="IValueConverter" />
    [ValueConversion(typeof(object), typeof(bool))]
    public sealed class TypeToInvertableBoolConverter : IValueConverter
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="TypeToInvertableBoolConverter"/> class.
        /// </summary>
        public TypeToInvertableBoolConverter()
        {
            IsInverted = false;
        }

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
            if (parameter != null)
            {
                throw new ArgumentException("parameter not supported", parameter.ToString());
            }

            bool finalValue = false;
            var workingValue = value ?? false;

            if (!workingValue.GetType().IsValueType)
            {
                finalValue = true;
            }
            else if (workingValue is string)
            {
                finalValue = !string.IsNullOrEmpty((string)workingValue);
            }
            else if (workingValue is int)
            {
                finalValue = ((int)workingValue > 0);
            }
            else if (workingValue is Enum)
            {
                finalValue = ((int)workingValue > 0);
            }
            else
            {
                finalValue = (bool)workingValue;
            }

            return IsInverted ? !finalValue : finalValue;
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