using System.Threading;
using System.Windows.Controls;
using System.Windows.Interactivity;

namespace ESFA.Common.Composition
{
    /// <summary>
    /// a combo box (itemsource changed) auto reset behaviour
    /// </summary>
    /// <seealso cref="System.Windows.Interactivity.Behavior{ComboBox}" />
    public sealed class ComboBoxAutoResetBehavior : Behavior<ComboBox>
    {
        /// <summary>
        /// Called when [attached].
        /// </summary>
        protected override void OnAttached()
        {
            base.OnAttached();
            if (AssociatedObject != null)
            {
                AssociatedObject.DataContextChanged += DataContextChanged;
            }
        }

        /// <summary>
        /// Called when [detaching].
        /// </summary>
        protected override void OnDetaching()
        {
            base.OnDetaching();
            if (AssociatedObject != null)
            {
                AssociatedObject.DataContextChanged -= DataContextChanged;
            }
        }

        /// <summary>
        /// Data context changed.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Windows.DependencyPropertyChangedEventArgs"/> instance containing the event data.</param>
        private void DataContextChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            SynchronizationContext.Current
                .Post(x =>
                {
                    AssociatedObject.SelectedIndex = -1;
                    AssociatedObject.SelectedIndex = 0;
                }, null);
        }
    }
}