using EasyOPA.Abstract;
using EasyOPA.Constant;
using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using System.IO;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// sql batch provider
    /// </summary>
    /// <seealso cref="FileConfigurationHostBase{SQLBatchConfiguration, IContainSQLBatches}" />
    /// <seealso cref="IProvideSQLBatches" />
    [Shared]
    [Export(typeof(IProvideSQLBatches))]
    public sealed class SQLBatchProvider :
        SpecialisedFileConfigurationHostBase<SQLBatchConfiguration, IContainSQLBatches>,
        IProvideSQLBatches
    {
        protected override string ConfigurationFilename => Asset.GetRunMode().SQLBatch; //"sqlbatch.cfg";

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
            Configured.Batches
                .ForEach(batch =>
                {
                    It.IsInRange(batch.Name, BatchProcessName.NotSet)
                        .AsGuard<ArgumentException>("name not set on batch");
                    It.IsEmpty(batch.Description)
                        .AsGuard<ArgumentException>($"description not set on batch: '{batch.Name}'");
                    It.IsInRange(batch.OperatingYear, BatchOperatingYear.NotSet)
                        .AsGuard<ArgumentException>($"operating year not set on batch: '{batch.Name}'");

                    // note: empty script blocks are now acceptable
                    //It.IsEmpty(batch.Scripts)
                    //    .AsGuard<ArgumentException>($"no scripts set for batch: '{batch.Name}'");

                    batch.Scripts
                        .ForEach(script =>
                        {
                            It.IsInRange(script.Type, TypeOfBatchScript.NotSet)
                                .AsGuard<ArgumentException>($"script type not set for script on batch: '{batch.Name}'");
                            It.IsEmpty(script.Description)
                                .AsGuard<ArgumentException>($"description not set for script on batch: '{batch.Name}'");
                            It.IsEmpty(script.Command)
                                .AsGuard<ArgumentException>($"command not set for script on batch: '{batch.Name}'");
                        });
                });
        }

        /// <summary>
        /// Gets the batch.
        /// </summary>
        /// <param name="byName">by Name</param>
        /// <returns>
        /// a batch detail
        /// </returns>
        public ISQLBatch GetBatch(BatchProcessName byName, BatchOperatingYear andYear = BatchOperatingYear.All)
        {
            return Configured.Batches.FirstOrDefault(x => x.Name == byName && x.OperatingYear == andYear);
        }

        /// <summary>
        /// Supplmental load.
        /// Once the intial load is conducted and a health check
        /// performed, we can do some supplemental stuff...
        /// </summary>
        /// <param name="onConcretion">on concretion.</param>
        public override void PerformSupplmentalLoad(SQLBatchConfiguration onConcretion)
        {
            if (!UseExperimental)
            {
                return;
            }

            // load the experimental SQL files from the asset folder.
            It.IsNull(onConcretion)
                .AsGuard<ArgumentNullException>(nameof(onConcretion));

            var yearList = GetYearList();
            yearList.ForEach(year =>
            {
                var workingFolder = Path.Combine(Location.OfAssets, year, Asset.Locations.Experimental);
                var files = GetFileInformationFor(workingFolder, EasyOPAConstant.ScriptFileSearchPattern);

                files.ForEach(file =>
                {
                    var shortCommand = Path.GetFileNameWithoutExtension(file);

                    var existing = onConcretion.Batches
                        .SelectMany(x => x.Scripts)
                        .Where(y => y.Command.Contains(year) && y.Command.Contains(shortCommand))
                        .AsSafeReadOnlyList();

                    // one file per 'year' of operation
                    var notFound = !It.HasCountOf(existing, 1);
                    notFound
                        .AsGuard<ArgumentException>($"unable to supplant original script: not found {shortCommand}");

                    existing.ForEach(x =>
                    {
                        x.Command = file;
                        x.Description = $"{x.Description} - Experimental script";
                    });
                });
            });
        }

        /// <summary>
        /// Gets the file information for.
        /// </summary>
        /// <param name="thisPath">The this path.</param>
        /// <param name="searchPattern">The search pattern.</param>
        /// <returns>a supplementary list of file names</returns>
        public IReadOnlyCollection<string> GetFileInformationFor(string thisPath, string searchPattern)
        {
            return Directory.Exists(thisPath)
                ? Directory.GetFiles(thisPath, searchPattern)
                : Collection.EmptyAndReadOnly<string>();
        }

        /// <summary>
        /// Gets the year list.
        /// </summary>
        /// <returns>a list of year 'folders'</returns>
        public IReadOnlyCollection<string> GetYearList()
        {
            var yearList = Collection.Empty<string>();
            var files = Directory.GetDirectories(Location.OfAssets);

            files.ForEach(file =>
            {
                var folder = Path.GetFileName(file);
                var result = folder.AsOperatingYear();
                if (result > BatchOperatingYear.All)
                {
                    yearList.Add(folder);
                }
            });

            return yearList.AsSafeReadOnlyList();
        }

        /// <summary>
        /// Changes the run mode.
        /// </summary>
        public override void ChangeRunMode()
        {
            Configure();
        }
    }
}
