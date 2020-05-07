using EasyOPA.Coordinator;
using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Service;
using EasyOPA.Set;
using ESFA.Common.Manager;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using SQLXMLBULKLOADLib;
using System;
using System.Composition;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// bulk load provider
    /// </summary>
    /// <seealso cref="IProvideBulkLoadingOperations" />
    [Shared]
    [Export(typeof(IProvideBulkLoadingOperations))]
    public sealed class BulkLoadProvider :
        IProvideBulkLoadingOperations
    {
        /// <summary>
        /// Gets or sets the context (coordinator).
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the (SQL) batch (provider).
        /// </summary>
        [Import]
        public IProvideSQLBatches Batches { get; set; }

        /// <summary>
        /// Gets or sets the file manager.
        /// </summary>
        [Import]
        public IManageTextFiles FileManager { get; set; }

        /// <summary>
        /// Gets or sets the schema.
        /// </summary>
        [Import]
        public IGenerateBulkLoadSchemas Schema { get; set; }

        /// <summary>
        /// Gets or sets the change year message.
        /// </summary>
        [Import]
        public ICreateChangeOperatingYearMessages ChangeYearMessage { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Loads...
        /// </summary>
        /// <param name="intoSource">into source.</param>
        /// <param name="onMaster">on master.</param>
        /// <param name="fromInputFile">from input file.</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        public async Task Load(IConnectionDetail intoSource, IConnectionDetail onMaster, string fromInputFile)
        {
            await Task.Run(async () =>
            {
                It.IsNull(intoSource)
                    .AsGuard<ArgumentNullException>(nameof(intoSource));
                It.IsNull(onMaster)
                    .AsGuard<ArgumentNullException>(nameof(onMaster));
                It.IsEmpty(fromInputFile)
                    .AsGuard<ArgumentNullException>(nameof(fromInputFile));

                //if (Context.DataStoreExists(intoSource.Name, onMaster))
                //{
                //    Context.DropDataStore(intoSource.Name, onMaster);
                //}

                Emitter.Publish($"Creating data store: {intoSource.DBName}");

                //Context.CreateDataStore(intoSource.Name, onMaster);

                var content = await FileManager.Load(fromInputFile); // <= very lazy and inefficient..
                var messageNamespace = GetHeaderNameSpace(content);

                It.IsEmpty(messageNamespace)
                    .AsGuard<ArgumentException, Localised>(Localised.UnableToRetrieveMessageNamespace);

                var buildSchema = await Schema.Generate(
                    messageNamespace,
                    intoSource,
                    (inContext, loadSchemaPath, createTables) =>
                    {
                        var loader = GetLoader(inContext, createTables);
                        loader.Execute(loadSchemaPath, fromInputFile);
                    });

                Mediator.Publish(ChangeYearMessage.Create(buildSchema.Year, buildSchema.Collection));

                var batchList = Batches.GetBatch(BatchProcessName.BuildSourceDataStore, buildSchema.Year);
                var s = batchList.Scripts.ElementAt(1).Command;
                s = s.Replace("originalFileName", Path.GetFileNameWithoutExtension(fromInputFile));
                batchList.Scripts.ElementAt(1).Command = s;

                Emitter.Publish(batchList.Description);

                Context.Run(batchList.Scripts, intoSource);
            });
        }

        /// <summary>
        /// Gets the header name space.
        /// </summary>
        /// <param name="content">The content.</param>
        /// <returns>a 'grepped' and cleansed message namespace</returns>
        public string GetHeaderNameSpace(string content)
        {
            It.IsEmpty(content)
                .AsGuard<ArgumentNullException>(nameof(content));

            // get the header part
            var msgHeader = content.Substring(content.IndexOf("<Message"), 200);

            // strip out the namespaces
            var temp = msgHeader
                .Substring(9, msgHeader.IndexOf(">"))
                .Split(new string[] { "xmlns" }, StringSplitOptions.RemoveEmptyEntries);

            // 'our' namespace doesn't have an alias
            var candidate = temp.FirstOrDefault(x => x.StartsWith("="));
            candidate = candidate.Substring(2, candidate.Length - 2);
            candidate = candidate.Substring(0, candidate.IndexOf("\""));

            return candidate;
        }

        /// <summary>
        /// Gets the loader.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="makeNew">if set to <c>true</c> [make new].</param>
        /// <returns>
        /// a bulk loader
        /// </returns>
        public ISQLXMLBulkLoad4 GetLoader(IConnectionDetail context, bool makeNew)
        {
            It.IsNull(context)
                .AsGuard<ArgumentNullException>(nameof(context));

            return new SQLXMLBulkLoad4
            {
                ConnectionString = context.COMDetail,
                ErrorLogFile = "LoadErrors.xml",
                KeepIdentity = false,
                SGDropTables = makeNew,
                SchemaGen = makeNew,
            };
        }
    }
}
