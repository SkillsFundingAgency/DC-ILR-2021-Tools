using System.Windows;

namespace ESFA.Common.Composition
{
    public sealed class BoundProperty : DependencyObject
    {
        /// <summary>
        /// The primary path property
        /// </summary>
        public static readonly DependencyProperty PrimaryProperty = DependencyProperty.RegisterAttached(
          "Primary",
          typeof(object),
          typeof(BoundProperty));

        /// <summary>
        /// Gets the primary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <returns></returns>
        public static object GetPrimary(DependencyObject obj)
        {
            return obj.GetValue(PrimaryProperty);
        }

        /// <summary>
        /// Sets the primary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <param name="value">The value.</param>
        public static void SetPrimary(DependencyObject obj, object value)
        {
            obj.SetValue(PrimaryProperty, value);
        }

        /// <summary>
        /// The secondary path property
        /// </summary>
        public static readonly DependencyProperty SecondaryProperty = DependencyProperty.RegisterAttached(
          "Secondary",
          typeof(object),
          typeof(BoundProperty));

        /// <summary>
        /// Gets the secondary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <returns></returns>
        public static object GetSecondary(DependencyObject obj)
        {
            return obj.GetValue(SecondaryProperty);
        }

        /// <summary>
        /// Sets the secondary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <param name="value">The value.</param>
        public static void SetSecondary(DependencyObject obj, object value)
        {
            obj.SetValue(SecondaryProperty, value);
        }

        /// <summary>
        /// The tertiary path property
        /// </summary>
        public static readonly DependencyProperty TertiaryProperty = DependencyProperty.RegisterAttached(
          "Tertiary",
          typeof(object),
          typeof(BoundProperty));

        /// <summary>
        /// Gets the tertiary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <returns></returns>
        public static object GetTertiary(DependencyObject obj)
        {
            return obj.GetValue(TertiaryProperty);
        }

        /// <summary>
        /// Sets the tertiary path.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <param name="value">The value.</param>
        public static void SetTertiary(DependencyObject obj, object value)
        {
            obj.SetValue(TertiaryProperty, value);
        }
    }
}