using EasyOPA.Coordinator;
using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.IO;
using System.Threading.Tasks;
using Tiny.Framework.Contracts;
using Tiny.Framework.Utilities;

namespace EasyOPA.Manager
{
    /// <summary>
    /// bulk operation manager
    /// </summary>
    /// <seealso cref="IManageBulkOperations" />
    [Shared]
    [Export(typeof(IManageBulkOperations))]
    public sealed class BulkOperationsManager :
        IManageBulkOperations
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the (data) context (operations coordinator).
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Gets or sets the handler.
        /// </summary>
        [Import]
        public IHandleSafeOperationResponses Handler { get; set; }

        /// <summary>
        /// Gets or sets the provider.
        /// </summary>
        [Import]
        public ICreateSessionContexts Provider { get; set; }

        /// <summary>
        /// Gets or sets the bulk loader.
        /// </summary>
        [Import]
        public IProvideBulkLoadingOperations BulkLoader { get; set; }

        /// <summary>
        /// Gets or sets the bulk exporter.
        /// </summary>
        [Import]
        public IProvideBulkExportOperations BulkExporter { get; set; }

        /// <summary>
        /// Gets or sets the localised string resource manager.
        /// </summary>
        [Import]
        public IResolveResources Locals { get; set; }

        /// <summary>
        /// Imports the file...
        /// </summary>
        /// <param name="usingInstance">using instance.</param>
        /// <param name="getFileName">get the name of the file</param>
        /// <param name="andConfirmAnyChallenge">and confirm any challenge.</param>
        /// <returns>
        /// the current task
        /// </returns>
        public async Task Import(string usingInstance, string usingDatabase ,string dbUser, string dbPassword, Func<string> getFileName, Func<string, bool> andConfirmAnyChallenge)
        {
            It.IsNull(getFileName)
                .AsGuard<ArgumentNullException>(nameof(getFileName));

            await Handler.RunAsyncOperation<Localised>(async () =>
            {
                Emitter.Publish("Selecting file...");

                var inputFilePath = getFileName();

                It.IsEmpty(inputFilePath)
                    .AsGuard<OperationCanceledException, CommonLocalised>(CommonLocalised.CanceledOperation);

                //var candidateSourceName = Path.GetFileNameWithoutExtension(inputFilePath);


                // check for DB overwrite...
                Emitter.Publish("Checking for risk of overwrite...");

                var master = Provider.ConnectionToMaster(usingInstance, usingDatabase, dbUser, dbPassword);

                //if (Context.DataStoreExists(candidateSourceName, master))
                //{
                //    var format = Locals.GetString(Localised.AboutToOverwriteDBFormat);
                //    var msg = Format.String(format, candidateSourceName);
                //    (!andConfirmAnyChallenge(msg))
                //        .AsGuard<OperationCanceledException, CommonLocalised>(CommonLocalised.CanceledOperation);
                //}

                var source = Provider.ConnectionToSource(usingInstance, usingDatabase, dbUser, dbPassword);

                await BulkLoader.Load(source, master, inputFilePath);
            });
        }

        /// <summary>
        /// Exports (the currently selected input source to ILR file).
        /// </summary>
        /// <param name="fromThisSource">From this source.</param>
        /// <param name="forProvider">For provider.</param>
        /// <returns>
        /// the current task
        /// </returns>
        public async Task Export(IInputDataSource fromThisSource, int forProvider)
        {
            await Handler.RunAsyncOperation<Localised>(async () =>
            {
                var context = Provider.ConnectionToSource(fromThisSource.Container, fromThisSource.DBName, fromThisSource.DBUser, fromThisSource.DBPassword);
                await BulkExporter.Export(fromThisSource, context, forProvider);
            });
        }
    }
}
