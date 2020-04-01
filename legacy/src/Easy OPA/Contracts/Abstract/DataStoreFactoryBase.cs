using EasyOPA.Constant;
using EasyOPA.Coordinator;
using EasyOPA.Indirect;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Utilities;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// data store factory base 
    /// </summary>
    /// <seealso cref="IPrepareStorage" />
    public abstract class DataStoreFactoryBase :
        ContentMapperBase<bool, Action<IContainSessionContext, int, BatchOperatingYear>>,
        IPrepareStorage
    {
        /// <summary>
        /// Gets or sets the (connection context) coordinator.
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Gets or sets the batches (provider).
        /// </summary>
        [Import]
        public IProvideSQLBatches Batches { get; set; }

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="DataStoreFactoryBase"/> class.
        /// </summary>
        public DataStoreFactoryBase()
        {
            Add(true, BuildStore);
            Add(false, StoreExists);
        }

        /// <summary>
        /// Gets the default.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns>
        /// <see typeparam="TMappedContent" />
        /// </returns>
        /// <exception cref="ArgumentOutOfRangeException">key</exception>
        public override Action<IContainSessionContext, int, BatchOperatingYear> FetchDefault(bool key)
        {
            throw new ArgumentOutOfRangeException(nameof(key));
        }

        /// <summary>
        /// Store exists, a cleanse routine will be executed
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public abstract void StoreExists(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear);

        /// <summary>
        /// Builds the store.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        public abstract void BuildStore(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear);

        /// <summary>
        /// Gets the name of the store for...
        /// </summary>
        /// <param name="thisSession">this session.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>the name of the required data store</returns>
        public abstract string GetStoreNameFor(IContainSessionContext inContext);

        /// <summary>
        /// Prepare...
        /// </summary>
        /// <param name="currentContext">current context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        /// <param name="forceCreation">if set to <c>true</c> [force creation].</param>
        public void Prepare(IContainSessionContext currentContext, int forProvider, BatchOperatingYear inYear, bool forceCreation)
        {
            It.IsNull(currentContext)
                .AsGuard<ArgumentNullException>(nameof(currentContext));
            It.IsInRange(inYear, BatchOperatingYear.NotSet)
                .AsGuard<ArgumentNullException>(nameof(inYear));

            var resultsStoreName = GetStoreNameFor(currentContext);
            //Emitter.Publish($"Placing results storage in '{resultsStoreName}'");

            var newStoreRequired = !Context.DataStoreExists(resultsStoreName, currentContext.Master);

            var actionDo = Fetch(newStoreRequired || forceCreation);
            actionDo(currentContext, forProvider, inYear);

            Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
        }

        /// <summary>
        /// Runs the script type check.
        /// </summary>
        /// <param name="scriptType">Type of the script.</param>
        /// <param name="expectedType">The expected type.</param>
        public void RunScriptTypeCheck(TypeOfBatchScript scriptType, TypeOfBatchScript expectedType)
        {
            var failedTypeCheck = !It.IsInRange(scriptType, expectedType);
            failedTypeCheck.AsGuard<ArgumentException>("script is not the right type");
        }

        /// <summary>
        /// Creates the data store using.
        /// </summary>
        /// <param name="thisSession">this session.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="usingScript">The create script.</param>
        public void CreateDataStoreUsing(IContainSessionContext inContext, ISQLBatchScript usingScript)
        {
            Emitter.Publish(Indentation.FirstLevel, usingScript.Description);

            Context.Run(usingScript, inContext.Master, x => GetSupplementaryTokenReplacements(x, inContext));
        }

        /// <summary>
        /// Gets the supplementary token replacements.
        /// </summary>
        /// <param name="candidate">The candidate.</param>
        /// <param name="inContext">The in context.</param>
        /// <returns></returns>
        public string GetSupplementaryTokenReplacements(string candidate, IContainSessionContext inContext)
        {
            return candidate.Replace(Token.ForTargetDataStore, GetStoreNameFor(inContext));
        }

        /// <summary>
        /// Creates the schema for...
        /// </summary>
        /// <param name="inContext">in context.</param>
        /// <param name="usingSchemaScripts">using schema scripts.</param>
        /// <param name="withSecondaryReplacements">with secondary replacements.</param>
        /// <returns></returns>
        public void CreateSchemaFor(IConnectionDetail inContext, IReadOnlyCollection<ISQLBatchScript> usingSchemaScripts, Func<string, string> withSecondaryReplacements)
        {
            Emitter.Publish(Indentation.FirstLevel, $"Adding structures to {inContext.DBName} data store");

            Context.Run(usingSchemaScripts, inContext, withSecondaryReplacements);
        }
    }
}
