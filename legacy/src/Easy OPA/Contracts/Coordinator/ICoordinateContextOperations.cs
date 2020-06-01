using EasyOPA.Model;
using System;
using System.Collections.Generic;

namespace EasyOPA.Coordinator
{
    /// <summary>
    /// i coordinate context operations 
    /// </summary>
    public interface ICoordinateContextOperations
    {
        /// <summary>
        /// Runs..
        /// </summary>
        /// <param name="theseBatchItems">these batch items.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="withSupplementaryTokenReplacements">with supplementary token replacements.</param>
        void Run(IReadOnlyCollection<ISQLBatchScript> theseBatchItems, IConnectionDetail inThisContext, Func<string, string> withSupplementaryTokenReplacements = null);

        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="thisBatchFile">this batch file.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="withSupplementaryTokenReplacements">with supplementary token replacements.</param>
        void Run(ISQLBatchScript thisBatchFile, IConnectionDetail inThisContext, Func<string, string> withSupplementaryTokenReplacements = null);

        /// <summary>
        /// Get atom...
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// an atom of type <typeparamref name="TReturn" />
        /// </returns>
        TReturn GetAtom<TReturn>(string usingThisCommand, IConnectionDetail inThisContext);

        /// <summary>
        /// Gets the list.
        /// </summary>
        /// <typeparam name="TReturn">The type of the return.</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// an list of type <typeparamref name="TReturn" />
        /// </returns>
        ICollection<TReturn> GetList<TReturn>(string usingThisCommand, IConnectionDetail inThisContext);

        /// <summary>
        /// Gets the items.
        /// </summary>
        /// <typeparam name="TReturn">The return type.</typeparam>
        /// <param name="usingThisCommand">using this command.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <param name="mappedProperties">The mapped properties.</param>
        /// <returns>        
        /// an list of type <typeparamref name="TReturn" />
        /// </returns>
        IReadOnlyCollection<TContract> GetItems<TReturn, TContract>(string usingThisCommand, IConnectionDetail inThisContext, params string[] mappedProperties)
            where TContract : class
            where TReturn : class, TContract, new();

        /// <summary>
        /// Data store exists?
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// true if it does
        /// </returns>
        bool DataStoreExists(string usingStoreName, IConnectionDetail inThisContext);

        /// <summary>
        /// Store table exists.
        /// </summary>
        /// <param name="usingThisName">using this name.</param>
        /// <param name="inThisContext">in this context.</param>
        /// <returns>
        /// true if it does
        /// </returns>
        bool StoreTableExists(string usingThisName, IConnectionDetail inThisContext);

        /// <summary>
        /// Creates the data store.
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        void CreateDataStore(string usingStoreName, IConnectionDetail inThisContext);

        /// <summary>
        /// Drop the data store.
        /// </summary>
        /// <param name="usingStoreName">using the name of the store.</param>
        /// <param name="inThisContext">in this context.</param>
        void DropDataStore(string usingStoreName, IConnectionDetail inThisContext);

        void ExecuteCommand(string command, IConnectionDetail context);
    }
}
