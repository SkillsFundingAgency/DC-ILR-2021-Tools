using EasyOPA.Set;
using EasyOPA.Utility;
using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace EasyOPA.Composition
{
    /// <summary>
    /// the boolean to visibility converter
    /// </summary>
    /// <seealso cref="IValueConverter" />
    [ValueConversion(typeof(BatchOperatingYear), typeof(string))]
    public sealed class BatchOperatingYearConverter : IValueConverter
    {
        /// <summary>
        /// Converts the specified value.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="targetType">Type of the target.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns>a string</returns>
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var operatingYear = (BatchOperatingYear)value;

            return operatingYear.AsString();
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