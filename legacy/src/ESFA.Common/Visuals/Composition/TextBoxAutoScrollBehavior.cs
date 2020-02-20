using System.Windows.Controls;
using System.Windows.Interactivity;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a scroll to end behaviour
    /// </summary>
    /// <seealso cref="Behavior{TextBox}" />
    public sealed class TextBoxAutoScrollBehavior : Behavior<TextBox>
    {
        /// <summary>
        /// Called when [attached].
        /// </summary>
        protected override void OnAttached()
        {
            base.OnAttached();
            if (It.Has(AssociatedObject))
            {
                AssociatedObject.TextChanged += TextChanged;
            }
        }

        /// <summary>
        /// Called when [detaching].
        /// </summary>
        protected override void OnDetaching()
        {
            base.OnDetaching();
            if (It.Has(AssociatedObject))
            {
                AssociatedObject.TextChanged -= TextChanged;
            }
        }

        /// <summary>
        /// Texts the changed.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="TextChangedEventArgs"/> instance containing the event data.</param>
        private void TextChanged(object sender, TextChangedEventArgs e)
        {
            if (It.Has(AssociatedObject)
                && AssociatedObject.IsVisible)
            {
                AssociatedObject?.ScrollToEnd();
            }
        }
    }
}