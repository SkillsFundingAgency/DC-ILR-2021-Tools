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
    [ValueConversion(typeof(bool), typeof(Visibility))]
    public sealed class InvertableBoolToVisibilityConverter : IValueConverter
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="InvertableBoolToVisibilityConverter"/> class.
        /// </summary>
        public InvertableBoolToVisibilityConverter()
        {
            TrueValue = Visibility.Visible;
            FalseValue = Visibility.Collapsed;
            IsInverted = false;
        }

        public Visibility TrueValue { get; private set; } // always visible

        public Visibility FalseValue { get; set; }        // default collapsed, but maybe you want hidden on occasion

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

            if (workingValue is string)
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

            return IsInverted
              ? (finalValue ? FalseValue : TrueValue)
              : (finalValue ? TrueValue : FalseValue);
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