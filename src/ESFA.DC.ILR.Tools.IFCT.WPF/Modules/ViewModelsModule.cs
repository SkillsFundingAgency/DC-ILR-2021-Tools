using Autofac;
using ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel;

namespace ESFA.DC.ILR.Desktop.WPF.Modules
{
    public class ViewModelsModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<MainViewModel>().SingleInstance();
            containerBuilder.RegisterType<AboutViewModel>().SingleInstance();
        }
    }
}