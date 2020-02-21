using CommonServiceLocator;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel
{
#pragma warning disable CA1822 // Warning about properties being static disabled, WPF framework does not like them being static!
    // This class contains references to all the view models in the application and provides an entry point for the bindings.
    public class ViewModelLocator
    {
        public MainViewModel Main => ServiceLocator.Current.GetInstance<MainViewModel>();

        public AboutViewModel About => ServiceLocator.Current.GetInstance<AboutViewModel>();
    }
#pragma warning restore CA1822
}