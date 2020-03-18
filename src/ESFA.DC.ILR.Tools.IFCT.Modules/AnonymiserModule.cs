using System.Linq;
using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Anonymise;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Modules
{
    public class AnonymiserModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Interface for the year Anonymiser entrypoint
            containerBuilder.RegisterType<Anonymiser>().As<IAnonymise<Message>>();

            // Single instance of the logger so that it records across class instances
            containerBuilder.RegisterType<AnonymiseLog>().As<IAnonymiseLog>().InstancePerLifetimeScope();

            // Register any classes from ESFA.DC.ILR.Tools.IFCT.Anonymise that implement IAnonymise<T> - These anonymise by class
            containerBuilder.RegisterAssemblyTypes(typeof(Anonymiser).Assembly)
             .Where(x => x.GetInterfaces().Any(i => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IAnonymise<>)))
             .AsImplementedInterfaces().InstancePerLifetimeScope();
        }
    }
}
