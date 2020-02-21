using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;
using System.Windows.Input;
using ESFA.DC.ILR.Tools.IFCT.WPF.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel
{
    public class AboutViewModel
    {
        public AboutViewModel()
        {
            CloseWindowCommand = new ParameterCommandHandler(
                (window) => CloseWindowCommandAction((ICloseable)window),
                () => true);
            AboutItems = new ObservableCollection<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>("Version Number:", Assembly.GetEntryAssembly().GetName().Version.ToString()),
            };
        }

        public ObservableCollection<KeyValuePair<string, string>> AboutItems { get; }

        public ICommand CloseWindowCommand { get; }

        public static void CloseWindowCommandAction(ICloseable window)
        {
            window?.Close();
        }
    }
}
