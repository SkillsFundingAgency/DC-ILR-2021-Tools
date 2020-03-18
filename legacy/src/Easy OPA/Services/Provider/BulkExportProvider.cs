using EasyOPA.Constant;
using EasyOPA.Coordinator;
using EasyOPA.Model;
using EasyOPA.Set;
using ESFA.Common.Factory;
using ESFA.Common.Manager;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// bulk export provider
    /// </summary>
    /// <seealso cref="IProvideBulkExportOperations" />
    [Shared]
    [Export(typeof(IProvideBulkExportOperations))]
    public sealed class BulkExportProvider :
        IProvideBulkExportOperations
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the context.
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Gets or sets the schema (provider).
        /// </summary>
        [Import]
        public IProvideSchemaConfigurations Schemas { get; set; }

        /// <summary>
        /// Gets or sets the (asset) location (provider).
        /// </summary>
        [Import]
        public IProvideAssetLocation Location { get; set; }

        /// <summary>
        /// Gets or sets the file manager.
        /// </summary>
        [Import]
        public IManageTextFiles FileManager { get; set; }

        /// <summary>
        /// Gets or sets the batch provider.
        /// </summary>
        [Import]
        public IProvideSQLBatches Batches { get; set; }

        /// <summary>
        /// Gets or sets the (schema) validator.
        /// </summary>
        [Import]
        public IValidateXMLFiles Validator { get; set; }

        /// <summary>
        /// Gets or sets the scoped timer.
        /// </summary>
        [Import]
        public ICreateScopedTimings Timing { get; set; }

        /// <summary>
        /// Exports to ILR
        /// </summary>
        /// <param name="usingSource">using source.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        public async Task Export(IInputDataSource usingSource, IConnectionDetail inContext, int forProvider)
        {
            It.IsNull(usingSource)
                .AsGuard<ArgumentNullException>(nameof(usingSource));
            It.IsNull(inContext)
                .AsGuard<ArgumentNullException>(nameof(inContext));

            await Task.Run(async () =>
            {
                using (Timing.BeginScope($"Export file for {forProvider}"))
                {
                    var schema = Schemas.GetSchema(usingSource.OperatingYear);
                    var schemaPath = Path.Combine(Location.OfAssets, schema.Message);
                    var templatePath = Path.Combine(Location.OfAssets, schema.BulkExport);
                    var candidate = await FileManager.Load(templatePath);
                    var batch = Batches.GetBatch(BatchProcessName.ExportSourceDataToILRFile, usingSource.OperatingYear);

                    candidate = candidate.Replace(Token.ForNamespace, schema.Namespace);

                    batch.Scripts
                        .ForEach(script => RunScript(script, inContext, forProvider, ref candidate));

                    var outputPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory), "exportILR.xml");
                    await FileManager.Save(outputPath, candidate);
                    await StripEmptyTags(outputPath);

                    Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);

                    (!await Validator.IsValid(outputPath, schemaPath))
                        .AsGuard<OperationCanceledException, CommonLocalised>(CommonLocalised.SchemaValidationFailed);
                }
            });
        }

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="script">The script.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="forCandidate">for candidate.</param>
        public void RunScript(ISQLBatchScript script, IConnectionDetail inContext, int forProvider, ref string forCandidate)
        {
            var result = Task.Run(async () =>
            {
                It.IsOutOfRange(script.Type, TypeOfBatchScript.File)
                    .AsGuard<ArgumentException>($"{script.Type}");

                Emitter.Publish(Localised.PerformingExportScript, script.Description);

                var commandPath = Path.Combine(Location.OfAssets, script.Command);
                var command = await FileManager.Load(commandPath);
                command = Token.DoSecondaryPass(command, forProvider);

                return Context.GetAtom<string>(command, inContext);
            }).Result;

            forCandidate = forCandidate.Replace(script.Description, result);

            Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
        }

        /// <summary>
        /// Strips the empty tags.
        /// </summary>
        /// <param name="fromFile">From file.</param>
        /// <returns></returns>
        public async Task StripEmptyTags(string fromFile)
        {
            await Task.Run(async () =>
            {
                It.IsEmpty(fromFile)
                    .AsGuard<ArgumentException>(nameof(fromFile));

                Emitter.Publish(Localised.PerformingXMLCleanup);

                var doc = XDocument.Load(fromFile);

                // remove empty nodes and attributes
                doc.Descendants()
                    .Where(e =>
                        (e.Attributes().All(a => a.IsNamespaceDeclaration || string.IsNullOrWhiteSpace(a.Value))
                        && string.IsNullOrWhiteSpace(e.Value)
                        && e.Descendants().SelectMany(c => c.Attributes()).All(ca => ca.IsNamespaceDeclaration || string.IsNullOrWhiteSpace(ca.Value))))
                    .Remove();

                Emitter.Publish(Localised.PerformingFinalSave);
                await FileManager.Save(fromFile, doc.ToString());
            });
        }
    }
}
