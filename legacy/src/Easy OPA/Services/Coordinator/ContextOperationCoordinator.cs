using EasyOPA.Factory;
using EasyOPA.Manager;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Composition;
using System.Data;
using Tiny.Framework.Utilities;

namespace EasyOPA.Coordinator
{
    /// <summary>
    /// SQL batch manager base 
    /// </summary>
    [Shared]
    [Export(typeof(ICoordinateContextOperations))]
    public sealed class ContextOperationCoordinator :
        ICoordinateContextOperations
    {
        /// <summary>
        /// The script splitters, all the conceived variations of 'go'
        /// accounts for unix and windows derived files
        /// </summary>
        private static readonly string[] scriptSplits = {
            "go\r\n",
            "GO\r\n",
            "\r\ngo",
            "\r\nGO",
            "go\n",
            "GO\n",
            "\ngo",
            "\nGO",
            "\tgo",
            "\tGO",
        };

        /// <summary>
        /// The replacements, simply an act of minification
        /// </summary>
        private static readonly Dictionary<string, string> replacements = new Dictionary<string, string>
        {
            ["\t"] = " ",
            ["  "] = " "
        };

        /// <summary>
        /// Gets or sets the (connection context) factory.
        /// </summary>
        [Import]
        public ICreateConnectionContexts Factory { get; set; }

        /// <summary>
        /// Gets or sets the configuration.
        /// </summary>
        [Import]
        public IProvideSQLBatches Configuration { get; set; }

        /// <summary>
        /// Gets or sets the token substitutor.
        /// </summary>
        [Import]
        public IProvideTokenSubstitution Pseudonyms { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the asset (manager).
        /// </summary>
        [Import]
        public IManageAssets Asset { get; set; }

        /// <summary>
        /// Gets the SQL operations...
        /// </summary>
        /// <param name="usingThisFile">using this file.</param>
        /// <param name="withSupplementaryTokenReplacements">with supplementary token replacements.</param>
        /// <returns>
        /// a list of batch operations
        /// </returns>
        public IReadOnlyCollection<string> GetSQLOperations(string usingThisFile, Func<string, string> withSupplementaryTokenReplacements)
        {
            It.IsEmpty(usingThisFile)
                .AsGuard<ArgumentNullException>(nameof(usingThisFile));

            var file = Asset.GetContent(usingThisFile).Result;
            var content = Pseudonyms.ReplaceTokensIn(file, withSupplementaryTokenReplacements);

            return CleanseSQLOperations(content);
        }

        /// <summary>
        /// Cleanses the SQL operations.
        /// </summary>
        /// <param name="usingThisContent">using this content</param>
        /// <returns>
        /// a list of cleansed SQL operations
        /// </returns>
        public IReadOnlyCollection<string> CleanseSQLOperations(string usingThisContent)
        {
            It.IsEmpty(usingThisContent)
                .AsGuard<ArgumentNullException>(nameof(usingThisContent));

            var temp = usingThisContent
                .Split(scriptSplits, StringSplitOptions.RemoveEmptyEntries)
                .AsSafeReadOnlyList();

            var results = new List<string>();

            // minify... this started with removing tabs on some statements, not sure why...
            // don't remove 'new lines' ("\r\n") as some scripts contain comments...
            temp.ForEach(x =>
            {
                var candidate = x;
                while (candidate.StartsWith("\r\n") || candidate.StartsWith("\n") || candidate.StartsWith(" \n"))
                {
                    var startPoint = candidate.IndexOf("\n") + 1;
                    candidate = candidate.Substring(startPoint);
                }

                replacements.ForEach(y => candidate = candidate.Replace(y.Key, y.Value));
                candidate = candidate.Trim();

                if (It.Has(candidate))
                {
                    results.Add(candidate);
                }
            });

            return results;
        }

        /// <summary>
        /// Using a connection.
        /// </summary>
        /// <param name="inThisContext">in this context; here meaning the connection details</param>
        /// <param name="runThisAction">run this action.</param>
        public void UsingConnection(IConnectionDetail inThisContext, Action<IConnectionContext> runThisAction)
        {
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));
            It.IsNull(runThisAction)
                .AsGuard<ArgumentNullException>(nameof(runThisAction));

            using (var con = Factory.Create(inThisContext))
            {
                try
                {
                    con.OpenSafe();
                    runThisAction(con);
                }
                catch (Exception e)
                {
                    Emitter.Publish(e.Message);
                    throw;
                }
            }
        }

        /// <summary>
        /// Using a connection.
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="inThisContext">in this context; here meaning the connection details</param>
        /// <param name="runThisAction">run this action.</param>
        /// <returns>
        /// the result of the function call
        /// </returns>
        public TReturn UsingConnection<TReturn>(IConnectionDetail inThisContext, Func<IConnectionContext, TReturn> runThisAction)
        {
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));
            It.IsNull(runThisAction)
                .AsGuard<ArgumentNullException>(nameof(runThisAction));

            using (var con = Factory.Create(inThisContext))
            {
                try
                {
                    Emitter.Publish($"UsingConnection");
                    con.OpenSafe();
                    return runThisAction(con);
                }
                catch (Exception)
                {
                    
                    throw;
                }
            }
        }


        /// <summary>
        /// Runs..
        /// </summary>
        /// <param name="theseBatchItems">these batch items.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="withSupplementaryTokenReplacements">with supplementary token replacements.</param>
        public void Run(
            IReadOnlyCollection<ISQLBatchScript> theseBatchItems,
            IConnectionDetail inThisContext,
            Func<string, string> withSupplementaryTokenReplacements)
        {
            // note: empty is safe, null is not...
            It.IsNull(theseBatchItems)
                .AsGuard<ArgumentNullException>(nameof(theseBatchItems));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            theseBatchItems
                .ForEach(script => Run(script, inThisContext, withSupplementaryTokenReplacements));
        }

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="thisBatchFile">this batch file.</param>
        /// <param name="inThisContext">The in this context.</param>
        /// <param name="withSupplementaryTokenReplacements">with supplementary token replacements.</param>
        public void Run(
            ISQLBatchScript thisBatchScript,
            IConnectionDetail inThisContext,
            Func<string, string> withSupplementaryTokenReplacements)
        {
            It.IsNull(thisBatchScript)
                .AsGuard<ArgumentNullException>(nameof(thisBatchScript));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            if (It.IsInRange(thisBatchScript.Type, TypeOfBatchScript.Ignored))
            {
                return;
            }

            Emitter.Publish(Indentation.FirstLevel, $"Running: '{thisBatchScript.Description}'");

            if (It.IsInRange(thisBatchScript.Type, TypeOfBatchScript.Statement))
            {
                var content = Pseudonyms.ReplaceTokensIn(thisBatchScript.Command, withSupplementaryTokenReplacements);
                UsingConnection(inThisContext, x => RunCommand(content, x));
                return;
            }

            var batches = GetSQLOperations(thisBatchScript.Command, withSupplementaryTokenReplacements);
            Emitter.Publish(Indentation.FirstLevel, $"Batch contains {batches.Count} statement{(batches.Count > 1 ? "s" : string.Empty)}.");

            Run(batches.AsSafeReadOnlyList(), inThisContext);
        }

        /// <summary>
        /// Runs..
        /// </summary>
        /// <param name="theseBatchItems">these batch items.</param>
        /// <param name="inThisContext">in this context.</param>
        public void Run(IReadOnlyCollection<string> theseBatchItems, IConnectionDetail inThisContext)
        {
            UsingConnection(inThisContext, x => theseBatchItems.ForEach(item => RunCommand(item, x)));
        }

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="thisCommand">this command.</param>
        /// <param name="forContext">for context.</param>
        /// <param name="withTimeout">with timeout (defaults to 10 minutes - 600 seconds)</param>
        public void RunCommand(string thisCommand, IConnectionContext forContext)
        {
            using (var cmd = CreateCommand(thisCommand, forContext))
            {
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Get atom...
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// an atom of type <typeparamref name="TReturn" />
        /// </returns>
        public TReturn GetAtom<TReturn>(string usingThisCommand, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingThisCommand)
                .AsGuard<ArgumentNullException>(nameof(usingThisCommand));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            return UsingConnection(inThisContext, x =>
            {
                using (var cmd = CreateCommand(usingThisCommand, x))
                {
                    var result = cmd.ExecuteScalar();
                    return GetValue<TReturn>(result);
                }
            });
        }

        public T GetSafe<T>(IDataReader reader, string columnName, T defaultValue = default(T))
        {
            It.IsNull(reader)
                .AsGuard<ArgumentNullException>(nameof(reader));
            It.IsEmpty(columnName)
                .AsGuard<ArgumentNullException>(nameof(columnName));

            var ordinal = GetSafeOrdinal(reader, columnName);

            It.IsInRange<int>(ordinal, -1)
                .AsGuard<ArgumentException>(columnName);

            return GetSafe(reader, ordinal, defaultValue);
        }

        /// <summary>
        /// Get safe T
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="reader">The reader.</param>
        /// <param name="ordinal">The ordinal.</param>
        /// <param name="defaultValue">The default value.</param>
        /// <returns>
        /// the value as type T
        /// </returns>
        public T GetSafe<T>(IDataReader reader, int ordinal, T defaultValue = default(T))
        {
            return reader.IsDBNull(ordinal) ? defaultValue : Get<T>(reader.GetValue(ordinal));
        }

        /// <summary>
        /// Gets the specified item.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="item">The item.</param>
        /// <returns>the item as a type of T</returns>
        public T Get<T>(object item)
        {
            return typeof(T).IsAssignableFrom(item.GetType())
                ? (T)item
                : (T)TypeDescriptor.GetConverter(typeof(T)).ConvertFrom(item);
        }

        /// <summary>
        /// Gets the safe ordinal.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="columnName">Name of the column.</param>
        /// <returns>the ordinal or -1 if not found</returns>
        public static int GetSafeOrdinal(IDataReader reader, string columnName)
        {
            try
            {
                return reader.GetOrdinal(columnName);
            }

            catch { return -1; }
        }

        /// <summary>
        /// From the data reader.
        /// this should work if property names match column names
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="reader">The dr.</param>
        /// <returns>a collection of T</returns>
        public IReadOnlyCollection<TContract> CollectionFromDataReader<TReturn, TContract>(IDataReader reader, string[] propertyNames)
            where TContract : class
            where TReturn : class, TContract, new()
        {
            It.IsNull(reader)
                .AsGuard<ArgumentNullException>(nameof(reader));

            var results = Collection.Empty<TContract>();
            var instance = default(TContract);

            do
            {
                instance = FromDataReader<TReturn, TContract>(reader, propertyNames);
                if (It.Has(instance))
                {
                    results.Add(instance);
                }
            }
            while (It.Has(instance));

            return results.AsSafeReadOnlyList();
        }

        /// <summary>
        /// From the data reader.
        /// this should work if property names match column names
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="reader">The dr.</param>
        /// <returns>a collection of T</returns>
        public TContract FromDataReader<TReturn, TContract>(IDataReader reader, string[] propertyNames)
            where TReturn : class, TContract, new()
        {
            It.IsNull(reader)
                .AsGuard<ArgumentNullException>(nameof(reader));

            var instance = default(TReturn);

            if (reader.Read())
            {
                instance = new TReturn();

                propertyNames.ForEach(name =>
                {
                    var property = typeof(TReturn).GetProperty(name);
                    var propertyValue = GetSafe(reader, name, property.GetValue(instance));

                    if (It.Has(property))
                    {
                        property.SetValue(instance, propertyValue);
                    }
                });
            }

            return instance;
        }

        /// <summary>
        /// Gets the list.
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// an list of type <typeparamref name="TReturn" />
        /// </returns>
        public ICollection<TReturn> GetList<TReturn>(string usingThisCommand, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingThisCommand)
                .AsGuard<ArgumentNullException>(nameof(usingThisCommand));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            return UsingConnection(inThisContext, x =>
            {
                var tempList = Collection.Empty<TReturn>();
                using (var cmd = CreateCommand(usingThisCommand, x))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var candidate = reader.GetValue(0);

                            tempList.Add(GetValue<TReturn>(candidate));
                        }
                    }
                }

                return tempList;
            });
        }

        /// <summary>
        /// Gets the items.
        /// this is a very simple list hydration class
        /// </summary>
        /// <typeparam name="TReturn">The return type.</typeparam>
        /// <typeparam name="TContract">the returning contract type</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="mappedProperties">with mapped properties.</param>
        /// <returns>
        /// an list of type <typeparamref name="TContract" />
        /// </returns>
        public IReadOnlyCollection<TContract> GetItems<TReturn, TContract>(string usingThisCommand, IConnectionDetail inThisContext, params string[] mappedProperties)
            where TContract : class
            where TReturn : class, TContract, new()
        {
            It.IsEmpty(usingThisCommand)
                .AsGuard<ArgumentNullException>(nameof(usingThisCommand));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            return UsingConnection(inThisContext, x =>
            {
                using (var cmd = CreateCommand(usingThisCommand, x))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        return CollectionFromDataReader<TReturn, TContract>(reader, mappedProperties);
                    }
                }
            });
        }

        /// <summary>
        /// Creates the command.
        /// </summary>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="withTimeout">with timeout.</param>
        /// <returns>
        /// a newly created command execution object
        /// </returns>
        public IDbCommand CreateCommand(string usingThisCommand, IConnectionContext inThisContext)
        {
            It.IsEmpty(usingThisCommand)
                .AsGuard<ArgumentNullException>(nameof(usingThisCommand));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            var command = inThisContext.Connection.CreateCommand();
            command.CommandText = usingThisCommand;
            command.CommandTimeout = Asset.ConnectionTimeout; // <= set a default timeout of 10 minutes
            return command;
        }

        /// <summary>
        /// Gets the value.
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="item">The item.</param>
        /// <returns>
        /// the converted value
        /// </returns>
        public TReturn GetValue<TReturn>(object item)
        {
            return It.Has(item)
                ? (TReturn)Convert.ChangeType(item, typeof(TReturn))
                : default(TReturn);
        }

        /// <summary>
        /// Data store exists?
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// the running task containing the result
        /// </returns>
        public bool DataStoreExists(string usingStoreName, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingStoreName)
                .AsGuard<ArgumentNullException>(nameof(usingStoreName));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            var usingCommand = $"if exists (select * from sys.databases where name = '{usingStoreName}') select 1 else select 0";
            return GetAtom<bool>(usingCommand, inThisContext);
        }

        /// <summary>
        /// Creates the data store.
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        public void CreateDataStore(string usingStoreName, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingStoreName)
                .AsGuard<ArgumentNullException>(nameof(usingStoreName));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            var command = $"create database [{usingStoreName}]";

            UsingConnection(inThisContext, x => RunCommand(command, x));
        }

        /// <summary>
        /// Drop the data store.
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        public void DropDataStore(string usingStoreName, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingStoreName)
                .AsGuard<ArgumentNullException>(nameof(usingStoreName));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            var command = $"drop database [{usingStoreName}]";

            UsingConnection(inThisContext, x => RunCommand(command, x));
        }

        /// <summary>
        /// Store table exists.
        /// </summary>
        /// <param name="usingThisName">using this name.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// true if it does
        /// </returns>
        public bool StoreTableExists(string usingThisName, IConnectionDetail inThisContext)
        {
            It.IsEmpty(usingThisName)
                .AsGuard<ArgumentNullException>(nameof(usingThisName));
            It.IsNull(inThisContext)
                .AsGuard<ArgumentNullException>(nameof(inThisContext));

            var usingCommand = $"if object_id('{usingThisName}','u') is not null select 1 else select 0";

            return GetAtom<bool>(usingCommand, inThisContext);
        }
    }
}
