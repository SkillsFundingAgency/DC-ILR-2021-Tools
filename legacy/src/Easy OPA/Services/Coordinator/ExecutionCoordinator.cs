using EasyOPA.Constant;
using EasyOPA.Coordinator;
using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Service;
using EasyOPA.Set;
using EasyOPA.Utility;
using ESFA.Common.Factory;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Utilities;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// the (rulebase) execution coordinator
    /// </summary>
    /// <seealso cref="ICoordinateExecutionRuns" />
    [Shared]
    [Export(typeof(ICoordinateExecutionRuns))]
    public sealed class ExecutionCoordinator :
        ContentMapperBase<TypeOfRulebaseExecution, Action<IRulebaseConfiguration, IContainSessionContext>>,
        ICoordinateExecutionRuns
    {
        /// <summary>
        /// Gets or sets the processing data store (factory).
        /// </summary>
        [Import]
        public ICreateProcessingDataStores ProcessingDataStore { get; set; }

        /// <summary>
        /// Gets or sets the results data store (factory).
        /// </summary>
        [Import]
        public ICreateResultsDataStores ResultsDataStore { get; set; }

        /// <summary>
        /// Gets or sets the source data (copier)
        /// </summary>
        [Import]
        public ICopySourceData SourceData { get; set; }

        /// <summary>
        /// Gets or sets the rules engine (container).
        /// </summary>
        [Import]
        public IRunRulebases RulesEngine { get; set; }

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the (connection context) coordinator.
        /// </summary>
        [Import]
        public ICoordinateContextOperations Coordinate { get; set; }

        /// <summary>
        /// Gets or sets the (safe operations) handler.
        /// </summary>
        [Import]
        public IHandleSafeOperationResponses Handler { get; set; }

        // TODO: reintroduce later when it's working
        ///// <summary>
        ///// Gets or sets the reports (generator)
        ///// </summary>
        //[Import]
        //public ICreateReports Reports { get; set; }

        /// <summary>
        /// Gets or sets the results (data copier)
        /// </summary>
        [Import]
        public ICopyResultsData Results { get; set; }

        /// <summary>
        /// Gets or sets the transformer.
        /// </summary>
        [Import]
        public ITransformInputPostValidation PostValidation { get; set; }

        /// <summary>
        /// Gets or sets the (progress) monitor.
        /// </summary>
        [Import]
        public IMonitorSessionProgress Monitor { get; set; }

        /// <summary>
        /// Gets or sets the scoped logging factory.
        /// </summary>
        [Import]
        public ICreateScopedLogging Logging { get; set; }

        /// <summary>
        /// Gets or sets the scoped timer.
        /// </summary>
        [Import]
        public ICreateScopedTimings Timing { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="ExecutionCoordinator"/> class.
        /// </summary>
        public ExecutionCoordinator()
        {
            Add(TypeOfRulebaseExecution.OPA, ExecuteOPAFor);
        }

        /// <summary>
        /// Gets the default, which is for SQLOnly a 'no-op'
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns>
        /// <see typeparam="TMappedContent" />
        /// </returns>
        public override Action<IRulebaseConfiguration, IContainSessionContext> FetchDefault(TypeOfRulebaseExecution key)
        {
            It.IsInRange(key, TypeOfRulebaseExecution.OPA)
                .AsGuard<ArgumentException>("the rulebase execution key (OPA) should not get here...");

            // i'm a 'no-op'
            return (x, y) =>
            {
                Emitter.Publish(Indentation.FirstLevel, $"Nothing to do for this type of rulebase");
            };
        }

        /// <summary>
        /// Executes the opa for.
        /// </summary>
        /// <param name="thisRule">The this rule.</param>
        /// <param name="usingThisContext">The using this context.</param>
        public void ExecuteOPAFor(IRulebaseConfiguration thisRule, IContainSessionContext usingThisContext)
        {
            using (Timing.BeginScope(thisRule.Name))
            {
                var result = RulesEngine.Run(thisRule, usingThisContext);
                if (usingThisContext.DepositRulebaseArtefacts)
                {
                    Emitter.Publish(Indentation.FirstLevel, $"Generated {result} XDS file artefact(s) for rule base {thisRule.Name}");
                }

                Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
            }
        }

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        public async Task Run(IContainSessionConfiguration usingSession, IContainSessionContext inContext)
        {
            await Handler.RunOperation<Localised>(() => RunRules(usingSession, inContext));
        }

        /// <summary>
        /// Runs the rules.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>the currently running task</returns>
        public void RunRules(IContainSessionConfiguration usingSession, IContainSessionContext inContext)
        {
            using (Timing.BeginScope("This processing run"))
            {
                if (RequiresReturnPeriod(usingSession, inContext))
                {
                    throw new Exception("Please pick a return period if you wish to run the AEC rulebase");
                }

                Emitter.Publish("Commencing run...");

                var providers = usingSession.InputDataSource.Providers
                    .Where(x => x.IsSelectedForProcessing);

                Monitor.SetProviderCount(providers.Count());

                providers.ForEach(usingProvider =>
                {
                    Monitor.IncrementPosition();
                    Monitor.SetLearnerCounts(0, usingProvider.LearnerCount, 0);

                    var fileName = $"{usingProvider.ID}_{DateTime.Now:yyyyMMdd-HHmmss}.log";
                    var firstInRun = Monitor.ProviderPosition == 1;

                    using (Logging.BeginScope(fileName, firstInRun))
                    {
                        using (Timing.BeginScope($"This provider '{usingProvider.ID}'", x => GetProcessingAverage(usingProvider.LearnerCount, x)))
                        {
                            // start the log
                            StartLog(usingSession, usingProvider, inContext);
                            // build
                            PrepareRun(usingSession, inContext, usingProvider.ID, firstInRun);
                            // validate
                            RunRulebaseSubset(TypeOfRulebaseOperation.Validation, usingSession.RulesToRun, inContext);
                            // transform
                            TransformInput(inContext, usingSession.InputDataSource.OperatingYear, usingProvider);
                            // calculate
                            RunRulebaseSubset(TypeOfRulebaseOperation.Calculation, usingSession.RulesToRun, inContext);
                            // complete
                            #region Needs new story to re-work this
                            //CompleteRun(usingSession, inContext, usingProvider.ID);
                            #endregion
                            // report
                            RunReport(usingSession, inContext);
                        }
                    }
                });

                // reset the badges
                Monitor.IncrementPosition();
                Monitor.SetLearnerCounts(0, 0, 0);
                Monitor.SetCaseCount(null, 0);
            }
        }

        /// <summary>
        /// Requires return period.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>true, if AEC included in run and no return period set</returns>
        public bool RequiresReturnPeriod(IContainSessionConfiguration usingSession, IContainSessionContext inContext) =>
            It.IsInRange(inContext.ReturnPeriod, ReturnPeriod.None)
                && usingSession.RulesToRun.Any(x => x.ShortName == "AEC");

        /// <summary>
        /// Gets the processing average.
        /// </summary>
        /// <param name="forLearners">for learners.</param>
        /// <param name="usingTiming">using timing.</param>
        /// <returns>an emittable log message</returns>
        public string GetProcessingAverage(int forLearners, TimeSpan usingTiming)
        {
            var average = usingTiming.TotalSeconds / forLearners;
            return $"Each learner of '{forLearners}' was processed in an average of '{average}' seconds (or portion thereof)";
        }

        /// <summary>
        /// Starts the log.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="andProvider">and provider.</param>
        public void StartLog(IContainSessionConfiguration usingSession, ILearningProvider andProvider, IContainSessionContext inContext)
        {
            Emitter.Publish($"Running job for provider '{andProvider.ID}'");
            Emitter.Publish($"The application is running in '{inContext.RunMode}' mode");
            Emitter.Publish($"The '{usingSession.InputDataSource.OperatingYear.AsString()}' ruleset will be used");
            Emitter.Publish($"This provider has {andProvider.LearnerCount} learners");
            Emitter.Publish(CommonLocalised.LineDivider);
        }

        /// <summary>
        /// Prepares the run.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="forThisProvider">For this provider.</param>
        public void PrepareRun(IContainSessionConfiguration usingSession, IContainSessionContext inContext, int forThisProvider, bool initalise)
        {
            using (Timing.BeginScope($"Preparation"))
            {
                var _inYear = usingSession.InputDataSource.OperatingYear;

                ProcessingDataStore.Prepare(inContext, forThisProvider, _inYear, initalise);
                SourceData.Clone(inContext, forThisProvider, _inYear);
            }
        }

        /// <summary>
        /// Runs the rulebase subset.
        /// </summary>
        /// <param name="thisOperation">this operation.</param>
        /// <param name="rulesToRun">(the) rules to run</param>
        /// <param name="inContext">in context.</param>
        public void RunRulebaseSubset(TypeOfRulebaseOperation thisOperation, IReadOnlyCollection<IRulebaseConfiguration> rulesToRun, IContainSessionContext inContext)
        {
            using (Timing.BeginScope($"{thisOperation} rules"))
            {
                Emitter.Publish($"Executing {thisOperation} rules");

                var ruleSubset = rulesToRun
                    .Where(x => x.OperationType == thisOperation)
                    .AsSafeReadOnlyList();

                ruleSubset.ForEach(rule =>
                {
                    var ruleAction = Fetch(rule.ExecutionType);

                    if (rule.PreRunRoutines.Any())
                    {
                        RunScripts("pre run", rule, rule.PreRunRoutines, inContext);
                    }

                    Emitter.Publish($"Executing the '{rule.ShortName}' rulebase");

                    if (It.IsInRange(rule.ExecutionType, TypeOfRulebaseExecution.OPA))
                    {
                        var count = GetInsertCaseCount(inContext.ProcessingLocation, rule);
                        Emitter.Publish(Indentation.FirstLevel, $"{count} case(s) created");
                        Monitor.SetCaseCount(rule.ShortName, count);
                    }

                    ruleAction.Invoke(rule, inContext);

                    if (rule.PostRunRoutines.Any())
                    {
                        RunScripts("post run", rule, rule.PostRunRoutines, inContext);
                    }
                });
            }
        }

        /// <summary>
        /// Runs the scripts.
        /// </summary>
        /// <param name="forAction">For action.</param>
        /// <param name="onRule">on rule.</param>
        /// <param name="usingScripts">using scripts.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>the currently running task</returns>
        public void RunScripts(string forAction, IRulebaseConfiguration onRule, IReadOnlyCollection<ISQLBatchScript> usingScripts, IContainSessionContext inContext)
        {
            using (Timing.BeginScope($"Running {forAction} procedures for '{onRule.ShortName}'"))
            {
                Emitter.Publish($"Executing {forAction} procedures for '{onRule.ShortName}'");

                Coordinate.Run(
                    usingScripts,
                    inContext.ProcessingLocation,
                    x => Token.DoSecondaryPass(x, onRule.OperatingYear, inContext.ProcessingLocation, inContext.ReturnPeriod));

                Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
            }
        }

        /// <summary>
        /// Gets the insert case count.
        /// </summary>
        /// <param name="detail">The detail.</param>
        /// <param name="shortName">The short name.</param>
        /// <returns>the count</returns>
        public int GetInsertCaseCount(IConnectionDetail detail, IRulebaseConfiguration rule)
        {
            Emitter.Publish(Indentation.FirstLevel, rule.InsertCount.Description);

            return Coordinate.GetAtom<int>(rule.InsertCount.Command, detail);
        }

        /// <summary>
        /// Transforms the input.
        /// </summary>
        /// <param name="inContext">in context.</param>
        /// <param name="forYear">for year.</param>
        /// <param name="andProvider">and provider.</param>
        public void TransformInput(IContainSessionContext inContext, BatchOperatingYear forYear, ILearningProvider andProvider)
        {
            using (Timing.BeginScope($"Tramsformation of input and second pass data enrichment"))
            {
                PostValidation.TransformInput(inContext, forYear);

                // update session counts (interaction feedback)
                SetLearnerCounts(inContext.ProcessingLocation, andProvider);
            }
        }

        /// <summary>
        /// Sets the learner counts.
        /// </summary>
        /// <param name="forConnection">for connection</param>
        /// <param name="usingProvider">using provider</param>
        public void SetLearnerCounts(IConnectionDetail forConnection, ILearningProvider usingProvider)
        {
            var valids = GetSchemaLearnerCount(forConnection, "valid");
            var invalids = GetSchemaLearnerCount(forConnection, "invalid");

            Emitter.Publish(Indentation.FirstLevel, $"{valids} valid record(s) created");
            Emitter.Publish(Indentation.FirstLevel, $"{invalids} invalid record(s) created");

            Monitor.SetLearnerCounts(invalids, usingProvider.LearnerCount, valids);
        }

        /// <summary>
        /// Gets the schema learner count.
        /// </summary>
        /// <param name="forConnection">For connection</param>
        /// <param name="thisSchema">(and) this schema</param>
        /// <returns>the count</returns>
        public int GetSchemaLearnerCount(IConnectionDetail forConnection, string thisSchema)
        {
            var command = $"select count(*) from {thisSchema}.Learner";
            return RunSafe.Try(() => Coordinate.GetAtom<int>(command, forConnection));
        }

        /// <summary>
        /// Completes the run.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="forThisProvider">for this provider.</param>
        public void CompleteRun(IContainSessionConfiguration usingSession, IContainSessionContext inContext, int forThisProvider)
        {
            using (Timing.BeginScope($"Completion"))
            {
                var _inYear = usingSession.InputDataSource.OperatingYear;

                ResultsDataStore.Prepare(inContext, forThisProvider, _inYear, forceCreation: true);
                Results.Clone(inContext, forThisProvider, _inYear);
            }
        }

        /*
        private static string[] _columns = {
            "AimSeqNumber",
            "ErrorString",
            "Severity",
            "FieldValues",
            "LearnRefNumber",
            "RuleId"
        };

        private static string reportCommand = "select * from [Report].[ValidationError] where Severity {0} 'E'";
         */

        /// <summary>
        /// Runs the report.
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        public void RunReport(IContainSessionConfiguration usingSession, IContainSessionContext inContext)
        {
            using (Timing.BeginScope($"Reporting"))
            {
                Emitter.Publish("Generating reports");

                Emitter.Publish(Indentation.FirstLevel, "***** Reports are not currently implemented *****");

                // TODO: fix report builders...

                //var sqlConn = new SqlConnection(_con);

                //var errorReport = _report.Create(_columns, new SqlCommand(string.Format(reportCommand, "="), sqlConn));
                //var warningReport = _report.Create(_columns, new SqlCommand(string.Format(reportCommand, "<>"), sqlConn));

                //if (!Directory.Exists(Path.Combine(AppContext.BaseDirectory, "Reports")))
                //{
                //    Directory.CreateDirectory(Path.Combine(AppContext.BaseDirectory, "Reports"));
                //}

                //Parallel.Invoke(
                //    () => File.WriteAllText(Path.Combine(AppContext.BaseDirectory, "Reports", "Errors.csv"), errorReport),
                //    () => File.WriteAllText(Path.Combine(AppContext.BaseDirectory, "Reports", "Warnings.csv"), warningReport));

                Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
            }
        }
    }
}
