using ESFA.Common.Utility;
using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a multi text formatter and converter
    /// </summary>
    /// <seealso cref="System.Windows.Data.IValueConverter" />
    [ValueConversion(typeof(bool), typeof(string))]
    public sealed class MultiTextConverter : IMultiValueConverter
    {
        /// <summary>
        /// Converts the specified values.
        /// </summary>
        /// <param name="values">The values.</param>
        /// <param name="targetType">Type of the target.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns></returns>
        public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
        {
            var format = parameter as string;
            return Format.String(format, values);
        }

        /// <summary>
        /// Converts the back.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <param name="targetTypes">The target types.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="culture">The culture.</param>
        /// <returns></returns>
        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            return new[] { DependencyProperty.UnsetValue };
        }
    }
}