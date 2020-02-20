using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Utility;
using ESFA.Common.Factory;
using ESFA.Common.Manager;
using OPAWrapperLIB;
using System.Composition;
using System.IO;
using System.Linq;
using Tiny.Framework.Contracts.FlowControl;

namespace EasyOPA.Service
{
    /// <summary>
    /// rulebase engine container
    /// </summary>
    /// <seealso cref="IRunRulebases" />
    [Shared]
    [Export(typeof(IRunRulebases))]
    public sealed class RulesEngineContainer :
        IRunRulebases
    {
        /// <summary>
        /// Gets or sets the configuration.
        /// </summary>
        [Import]
        public IProvideRulebaseConfigurations Configuration { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the (folder monitoring message) factory.
        /// </summary>
        [Import]
        public ICreatePathMonitoringRequests Factory { get; set; }

        [Import]
        public IManageTextFiles Manager { get; set; }

        /// <summary>
        /// Builds the rules engine.
        /// </summary>
        /// <param name="session">The session.</param>
        /// <param name="context">The context.</param>
        /// <returns>the OPA rule engine wrapper</returns>
        public OPAWrapperLib BuildRulesEngine(IConnectionDetail context, IRulebaseConfiguration rulebase, bool depositXDSFiles)
        {
            var opaConfiguration = Configuration.GetOPAConfigurationFor(rulebase);

            var wrapper = new OPAWrapperLib(opaConfiguration.AsDocument());

            wrapper.XslFile = Configuration.GetOPATransformationPathFor(rulebase);
            wrapper.SetLoggingLevel(LoggingType.Error);
            wrapper.EnableTiming = false;
            wrapper.Log2Console = false;

            if (depositXDSFiles)
            {
                var dumpPath = Manager.CreateOperatingFolder("Easy OPA Rulebase Files", rulebase.ShortName, rulebase.OperatingYear.AsString()).Result;
                wrapper.DumpXdsFileName = "UKPRN@global,LearnRefNumber@Learner";
                wrapper.DumpXdsPath = dumpPath;
            }

            wrapper.AddConString("LoggingDB", context.SQLDetail);
            wrapper.AddConString("ILR", context.SQLDetail); // ???
            wrapper.NumberOfThreads = rulebase.DegreeOfParallelism;

            return wrapper;
        }

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="thisRule">this rule.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>
        /// the number of rulebase artefacts generated
        /// </returns>
        public int Run(IRulebaseConfiguration thisRule, IContainSessionContext inContext)
        {
            var depositArtefacts = inContext.DepositRulebaseArtefacts;
            var ruleEngine = BuildRulesEngine(inContext.ProcessingLocation, thisRule, depositArtefacts);
            var dumpPath = ruleEngine.DumpXdsPath;

            // start folder monitoring
            if (depositArtefacts)
            {
                Mediator.Publish(Factory.Create(dumpPath, "XDS"));
            }

            ruleEngine.Run();

            // cease folder monitoring
            if (depositArtefacts)
            {
                Mediator.Publish(Factory.Create());

                var files = Directory.EnumerateFiles(dumpPath);
                return files.Count();
            }

            return -1;
        }
    }
}
