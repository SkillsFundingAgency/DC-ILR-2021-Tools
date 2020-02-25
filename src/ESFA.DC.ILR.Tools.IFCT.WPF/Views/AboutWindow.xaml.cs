using System.Windows;
using ESFA.DC.ILR.Tools.IFCT.WPF.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.Views
{
    /// <summary>
    /// Interaction logic for AboutWindow.xaml.
    /// </summary>
    public partial class AboutWindow : Window, ICloseable
    {
        public AboutWindow()
        {
            InitializeComponent();
        }
    }
}
