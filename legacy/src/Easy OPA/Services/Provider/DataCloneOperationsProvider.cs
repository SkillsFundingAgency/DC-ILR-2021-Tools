using EasyOPA.Model;
using EasyOPA.Properties;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// the data cloning operations provider
    /// </summary>
    /// <seealso cref="IProvideDataCloningOperations" />
    [Shared]
    [Export(typeof(IProvideDataCloningOperations))]
    public sealed class DataCloneOperationsProvider :
        IProvideDataCloningOperations
    {
        /// <summary>
        /// The default batch size
        /// </summary>
        private const int _defaultBatchSize = 500;

        /// <summary>
        /// The default timeout
        /// </summary>
        private const int _defaultTimeout = 30;

        /// <summary>
        /// enable streaming
        /// </summary>
        private const bool _enableStreaming = true;

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Clone...
        /// </summary>
        /// <param name="usingMappings">using (table) mappings.</param>
        /// <param name="fromDataSource">from data source.</param>
        /// <param name="toDataTarget">to data target.</param>
        /// <param name="forProvider">for provider.</param>
        public void Clone(IReadOnlyCollection<IMapCloneEntityDetails> usingMappings, IConnectionDetail fromDataSource, IConnectionDetail toDataTarget, int forProvider)
        {
            using (var writeConnection = new SqlConnection(toDataTarget.SQLDetail))
            {
                writeConnection.Open();
                var sqlTransaction = writeConnection.BeginTransaction();

                try
                {
                    using (var readConnection = new SqlConnection(fromDataSource.SQLDetail))
                    {
                        readConnection.Open();

                        using (var copier = Build(writeConnection, sqlTransaction))
                        {
                            usingMappings.ForEach(mapping =>
                            {
                                Configure(copier, mapping);

                                Emitter.Publish(Indentation.FirstLevel, Localised.CloningDataFormat, mapping.Master);

                                var command = $"select {string.Join(", ", mapping.Attributes.Select(x => x.Master))} from {mapping.Master} where UKPRN = {forProvider}";
                                Execute(command, readConnection, x => copier.WriteToServer(x));
                            });
                        }
                    }

                    sqlTransaction.Commit();
                    Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
                }

                catch (Exception exception)
                {
                    sqlTransaction.Rollback();

                    throw (exception);
                }
            }
        }

        /// <summary>
        /// Builds (the copier).
        /// </summary>
        /// <param name="usingConnection">using connection.</param>
        /// <param name="withTransaction">with transaction.</param>
        /// <returns></returns>
        public SqlBulkCopy Build(SqlConnection usingConnection, SqlTransaction withTransaction)
        {
            var copier = new SqlBulkCopy(usingConnection, SqlBulkCopyOptions.Default, withTransaction)
            {
                BatchSize = _defaultBatchSize,
                BulkCopyTimeout = _defaultTimeout,
                EnableStreaming = _enableStreaming,
            };

            return copier;
        }

        /// <summary>
        /// Configures..
        /// </summary>
        /// <param name="thisCopier">this copier.</param>
        /// <param name="forTableMapping">for table mapping.</param>
        public void Configure(SqlBulkCopy thisCopier, IMapCloneEntityDetails forTableMapping)
        {
            thisCopier.DestinationTableName = forTableMapping.Target;

            thisCopier.ColumnMappings.Clear();
            forTableMapping.Attributes.ForEach(x => thisCopier.ColumnMappings.Add(x.AsBulkCopyColumnMapping()));
        }

        /// <summary>
        /// Execute...
        /// </summary>
        /// <param name="thisStatement">this statement.</param>
        /// <param name="onConnection">on connection.</param>
        /// <param name="doDataWrite">do data write</param>
        public void Execute(string thisStatement, SqlConnection onConnection, Action<DataTable> doDataWrite)
        {
            using (var adapter = new SqlDataAdapter(thisStatement, onConnection))
            {
                var withDataSet = new DataSet();
                adapter.Fill(withDataSet);
                doDataWrite(withDataSet.Tables[0]);
            }
        }
    }
}
