using EasyOPA.ViewModel;
using System.Composition;
using System.Windows.Controls;
using Tiny.Framework.Contracts;
using System.Windows;

namespace EasyOPA.View
{
    /// <summary>
    /// this is the root element so it can be shared
    /// </summary>
    [Shared]
    [Export]
    public sealed partial class MainPage : Page, IShellView
    {
        private bool _initialised = false;
        private IMainViewModel _model;

        [ImportingConstructor]
        public MainPage(IMainViewModel model)
        {
            InitializeComponent();
            DataContext = _model = model;
            IsVisibleChanged += MainPage_IsVisibleChanged;
        }

        /// <summary>
        /// Handles the IsVisibleChanged event of the MainPage control.
        /// 
        /// this should be done as a property trigger or behaviour and not done in 'code behind'...
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DependencyPropertyChangedEventArgs"/> instance containing the event data.</param>
        private void MainPage_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (!_initialised)
            {
                _initialised = true;
                _model.Clear();
            }
        }
    }
}
