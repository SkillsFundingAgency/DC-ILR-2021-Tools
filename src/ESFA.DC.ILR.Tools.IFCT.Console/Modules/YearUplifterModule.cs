using System.Linq;
using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using ESFA.DC.ILR.Tools.YearUpdate;
using ESFA.DC.ILR.Tools.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Console.Modules
{
    public class YearUplifterModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Interfaces for the year uplifter
            containerBuilder.RegisterType<YearUpdateConfiguration>().As<IYearUpdateConfiguration>();
            containerBuilder.RegisterType<YearUpdater>().As<IProcess<Message>>();

            // Register any classes from ESFA.DC.ILR.Tools.IFCT.YearUpdate that implement IUpLifter<T>
            containerBuilder.RegisterAssemblyTypes(typeof(MessageUplifter).Assembly)
              .Where(x => x.GetInterfaces().Any(i => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IUplifter<>)))
              .AsImplementedInterfaces().InstancePerLifetimeScope();

            containerBuilder.RegisterType<RuleProvider>().As<IRuleProvider>();
        }
    }
}
