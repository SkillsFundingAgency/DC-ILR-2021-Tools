using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using System.IO;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// rulebase configuration provider
    /// </summary>
    /// <seealso cref="FileConfigurationHostBase{RulesetConfiguration, IContainRulesetConfiguration}" />
    /// <seealso cref="IProvideRulebaseConfigurations" />
    [Shared]
    [Export(typeof(IProvideRulebaseConfigurations))]
    public sealed class RulebaseConfigurationProvider :
        SpecialisedFileConfigurationHostBase<RulesetConfiguration, IContainRulesetConfiguration>,
        IProvideRulebaseConfigurations
    {
        private const string fileCountFailedMsg = "Incorrect number of {0} files found for rulebase {1}";
        private const string matchFailedMsg = "Incorrect {0} name of {1} found for rulebase {2}";

        /// <summary>
        /// Gets or sets the message (factory).
        /// </summary>
        [Import]
        public ICreateRulesetConfigurationChangedMessages Message { get; set; }

        /// <summary>
        /// Gets or sets the schema (provider).
        /// </summary>
        [Import]
        public IProvideSchemaConfigurations Schema { get; set; }

        /// <summary>
        /// The configuration filename
        /// </summary>
        protected override string ConfigurationFilename => Asset.GetRunMode().Rulebase; //"rulebase.cfg";

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>
        /// the path to the configuration file
        /// </returns>
        public override string GetLoadPath()
        {
            return Path.Combine(Location.OfAssets, ConfigurationFilename);
        }

        /// <summary>
        /// Performs the health check.
        /// </summary>
        public override void PerformHealthCheck()
        {
            // health check on load
            Configured.Rulebases.ForEach(rulebase =>
            {
                It.IsEmpty(rulebase.Name)
                    .AsGuard<ArgumentException>("name not set on rulebase");
                It.IsEmpty(rulebase.ShortName)
                    .AsGuard<ArgumentException>("shortname not set on rulebase");
                It.IsInRange(rulebase.OperatingYear, BatchOperatingYear.NotSet)
                    .AsGuard<ArgumentException>($"operating year not set on: '{rulebase.ShortName}'");
                It.IsInRange(rulebase.ExecutionType, TypeOfRulebaseExecution.NotSet)
                    .AsGuard<ArgumentException>($"execution type not set on: '{rulebase.ShortName}'");
                It.IsInRange(rulebase.OperationType, TypeOfRulebaseOperation.NotSet)
                    .AsGuard<ArgumentException>($"operation type not set on: '{rulebase.ShortName}'");

                // OPA rules only
                if (It.IsInRange(rulebase.ExecutionType, TypeOfRulebaseExecution.OPA))
                {
                    // Insert count script check
                    It.IsNull(rulebase.InsertCount)
                        .AsGuard<ArgumentException>($"'{rulebase.ShortName}' does not contain a count insert cases script");
                    It.IsEmpty(rulebase.InsertCount.Command)
                        .AsGuard<ArgumentException>($"'{rulebase.ShortName}' contains an empty count insert cases script");
                    It.IsInRange(rulebase.InsertCount.Type, TypeOfBatchScript.NotSet, TypeOfBatchScript.File)
                        .AsGuard<ArgumentException>($"'{rulebase.ShortName}' count insert cases script type is invalid");

                    // OPA configuration checks
                    It.IsEmpty(rulebase.OPAConfiguration)
                        .AsGuard<ArgumentException>("opa configuration not set on rulebase");
                    It.IsEmpty(rulebase.OPATransform)
                        .AsGuard<ArgumentException>("opa configuration not set on rulebase");
                }

                rulebase.PostRunRoutines
                    .ForEach(x =>
                    {
                        It.IsEmpty(x.Command)
                            .AsGuard<ArgumentException>($"'{rulebase.ShortName}' contains an empty post execution script");
                        // we only expect statements here
                        It.IsInRange(x.Type, TypeOfBatchScript.NotSet)
                            .AsGuard<ArgumentException>($"'{rulebase.ShortName}' count post execution script type is invalid");
                    });

                rulebase.PreRunRoutines
                    .ForEach(x =>
                    {
                        It.IsEmpty(x.Command)
                            .AsGuard<ArgumentException>($"'{rulebase.ShortName}' contains an empty pre execution script");
                        // we only expect statements here
                        It.IsInRange(x.Type, TypeOfBatchScript.NotSet)
                            .AsGuard<ArgumentException>($"'{rulebase.ShortName}' pre execution script type is invalid");
                    });
            });
        }

        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        public IReadOnlyCollection<IRulebaseConfiguration> Rulebases => Configured.Rulebases;

        /// <summary>
        /// Gets the file information for.
        /// </summary>
        /// <param name="thisPath">this path.</param>
        /// <param name="andSearchPattern">and search pattern.</param>
        /// <returns>a list of suitable file names</returns>
        public IReadOnlyCollection<string> GetFileInformationFor(string thisPath, string searchPattern)
        {
            return Directory.Exists(thisPath)
                ? Directory.GetFiles(thisPath, searchPattern)
                : Collection.EmptyAndReadOnly<string>();
        }

        /// <summary>
        /// Gets the opa configuration for.
        /// </summary>
        /// <param name="thisRulebase">this rulebase.</param>
        /// <returns>
        /// the cleansed and detokenised configuration file
        /// </returns>
        public string GetOPAConfigurationFor(IRulebaseConfiguration thisRulebase)
        {
            var operatingYear = thisRulebase.OperatingYear.AsString();
            var workingFolder = thisRulebase.PointerToZip;
            var candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPAConfig, thisRulebase.ShortName);
            var files = GetFileInformationFor(candidatePath, EasyOPAConstant.ConfigurationFileSearchPattern);

            if (!files.Any())
            {
                workingFolder = Path.Combine(Location.OfAssets, operatingYear, Asset.Locations.Production);
                candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPAConfig, thisRulebase.ShortName);
                files = GetFileInformationFor(candidatePath, EasyOPAConstant.ConfigurationFileSearchPattern);
            }

            var failedCount = !It.HasCountOf(files, 1);
            failedCount.
                AsGuard<ArgumentException>(Format.String(fileCountFailedMsg, "configuration", thisRulebase.ShortName));

            var candidate = files.First();
            var fileName = Path.GetFileName(candidate);

            var failedMatch = It.IsDifferent(fileName, thisRulebase.OPAConfiguration);
            failedMatch
                .AsGuard<ArgumentException>(Format.String(matchFailedMsg, "configuration", fileName, thisRulebase.ShortName));

            var schema = Schema.GetSchema(thisRulebase.OperatingYear);

            // regardless of where the configuration files are, 
            // we always set the location of the zip file to the pointer
            return File
                .ReadAllText(candidate)
                .Replace(Token.ForWorkingFolder, thisRulebase.PointerToZip)
                .Replace(Token.ForPeriodStartDate, schema.PeriodStartDate);
        }

        /// <summary>
        /// Gets the opa transformation path for.
        /// </summary>
        /// <param name="thisRulebase">this rulebase.</param>
        /// <returns>
        /// the path to the transformation file
        /// </returns>
        public string GetOPATransformationPathFor(IRulebaseConfiguration thisRulebase)
        {
            var operatingYear = thisRulebase.OperatingYear.AsString();
            var workingFolder = thisRulebase.PointerToZip;
            var candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPARules, thisRulebase.ShortName);
            var files = GetFileInformationFor(candidatePath, EasyOPAConstant.TransformationFileSearchPattern);

            if (!files.Any())
            {
                workingFolder = Path.Combine(Location.OfAssets, operatingYear, Asset.Locations.Production);
                candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPARules, thisRulebase.ShortName);
                files = GetFileInformationFor(candidatePath, EasyOPAConstant.TransformationFileSearchPattern);
            }

            var failedCount = !It.HasCountOf(files, 1);
            failedCount.
                AsGuard<ArgumentException>(Format.String(fileCountFailedMsg, "transformation", thisRulebase.ShortName));

            var candidate = files.First();
            var fileName = Path.GetFileName(candidate);

            var failedMatch = It.IsDifferent(fileName, thisRulebase.OPATransform);
            failedMatch
                .AsGuard<ArgumentException>(Format.String(matchFailedMsg, "transformation", fileName, thisRulebase.ShortName));

            return candidate;
        }

        /// <summary>
        /// Perform supplmental load.
        /// Once the intial load is conducted and a health check
        /// performed, we can do some supplemental stuff...
        /// </summary>
        /// <param name="onConcretion">on concretion.</param>
        public override void PerformSupplmentalLoad(RulesetConfiguration onConcretion)
        {
            // rulebase configuration for experimental loads
            onConcretion.Rulebases
                .Where(x => x.ExecutionType == TypeOfRulebaseExecution.OPA)
                .ForEach(rulebase =>
                {
                    var isExperimental = true;
                    var operatingYear = rulebase.OperatingYear.AsString();
                    var workingFolder = Path.Combine(Location.OfAssets, operatingYear, Asset.Locations.Experimental);
                    var candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPARules, rulebase.ShortName);
                    var files = GetFileInformationFor(candidatePath, EasyOPAConstant.ZipFileSearchPattern);

                    if (!UseExperimental || !files.Any())
                    {
                        isExperimental = false;
                        workingFolder = Path.Combine(Location.OfAssets, operatingYear, Asset.Locations.Production);
                        candidatePath = Path.Combine(workingFolder, Asset.FolderNames.OPARules, rulebase.ShortName);
                        files = GetFileInformationFor(candidatePath, EasyOPAConstant.ZipFileSearchPattern);
                    }

                    var failedCount = !It.HasCountOf(files, 1);
                    failedCount
                        .AsGuard<ArgumentException>(Format.String(fileCountFailedMsg, "zip", rulebase.ShortName));

                    rulebase.Set(UseExperimental && isExperimental, workingFolder);
                });

            Mediator.Publish(Message.Create(Configured.Rulebases));
        }

        /// <summary>
        /// Changes the run mode.
        /// </summary>
        public override void ChangeRunMode()
        {
            Configure();
            if (!UseExperimental)
            {
                Mediator.Publish(Message.Create(Configured.Rulebases));
            }
        }
    }
}
