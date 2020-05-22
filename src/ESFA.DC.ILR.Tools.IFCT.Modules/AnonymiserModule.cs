using System.Linq;
using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Anonymise;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.ReferenceProviders;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Modules
{
    public class AnonymiserModule : Module
    {
        protected override void Load(ContainerBuilder containerBuilder)
        {
            // Interface for the year Anonymiser entrypoint
            containerBuilder.RegisterType<Anonymiser>().As<IAnonymise<Message>>();

            // Lifetime scope instance of the logger and ref providers so that they record / provide across class instances during the processing of a single file.
            containerBuilder.RegisterType<AnonymiseLog>().As<IAnonymiseLog>().InstancePerLifetimeScope();
            containerBuilder.RegisterType<ULNProvider>().As<IReferenceProvider<long>>().InstancePerLifetimeScope();
            containerBuilder.RegisterType<LearnerReferenceProvider>().As<IReferenceProvider<string>>().InstancePerLifetimeScope();

            // Register any classes from ESFA.DC.ILR.Tools.IFCT.Anonymise that implement IAnonymise<T> - These anonymise by class
            containerBuilder.RegisterAssemblyTypes(typeof(Anonymiser).Assembly)
             .Where(x => x.GetInterfaces().Any(i => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IAnonymise<>)))
             .AsImplementedInterfaces().InstancePerLifetimeScope();
        }
    }
}
