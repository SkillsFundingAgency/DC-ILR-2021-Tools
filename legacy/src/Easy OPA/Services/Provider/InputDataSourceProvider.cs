using EasyOPA.Constant;
using EasyOPA.Coordinator;
using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using ESFA.Common.Model;
using ESFA.Common.Service;
using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    [Shared]
    [Export(typeof(IProvideInputDataSources))]
    public sealed class InputDataSourceProvider :
        IProvideInputDataSources
    {
        /// <summary>
        /// Gets or sets the operation manager.
        /// </summary>
        [Import]
        public IConductSafeOperations OperationManager { get; set; }

        /// <summary>
        /// Gets or sets the batches.
        /// </summary>
        [Import]
        public IProvideSQLBatches Batches { get; set; }

        /// <summary>
        /// Gets or sets the (token) substitute (provider).
        /// </summary>
        [Import]
        public IProvideTokenSubstitution Substitute { get; set; }

        /// <summary>
        /// Gets or sets the context.
        /// </summary>
        [Import]
        public ICoordinateContextOperations Context { get; set; }

        /// <summary>
        /// Composes this instance.
        /// </summary>
        [OnImportsSatisfied]
        public void Compose()
        {
            Batches.Compose();
            Substitute.Compose();
        }

        /// <summary>
        /// Gets the candidates.
        /// </summary>
        /// <param name="forContext">For context.</param>
        /// <returns>
        /// returns a list of verified input data sources
        /// </returns>
        public async Task<IReadOnlyCollection<IInputDataSource>> GetCandidates(IConnectionDetail forContext)
        {
            // had to restrict the async operations here as some of the threads didn't appear to 
            // be returning properly. this may be due to the expectation of failure when interrogating 
            // some data sources.
            // i suppose it could be a bug in the oepration manager, brought on by the context switching
            // pondering...
            return await Task.Run(() =>
            {
                var candidates = Collection.Empty<IInputDataSource>();
                var script = GetScript(BatchProcessName.GetInputSourceCandidates);

                var candidateNames = Context.GetList<string>(script, forContext);

                candidateNames.ForEach(candidate =>
                {
                    var response = Load(forContext, candidate);

                    if (response.IsSuccess())
                    {
                        candidates.Add(response.Payload);
                    }
                });

                return candidates.AsSafeReadOnlyList();
            });
        }

        /// <summary>
        /// Loads...
        /// </summary>
        /// <param name="usingDetail">using detail.</param>
        /// <param name="withCandidate">with candidate.</param>
        /// <returns>
        /// an operational response that may contain an input data source
        /// (depends on the success of the check)
        /// </returns>
        public IOperationResponse<IInputDataSource> Load(IConnectionDetail usingDetail, string withCandidate)
        {
            // we expect this to fail as not all data sources will contain 
            // collection detail information. an execption is not a problem 
            // when it forms part of the control flow
            return OperationManager.RunSafe(() => CheckCandidate(usingDetail, withCandidate));
        }

        /// <summary>
        /// Checks the candidate.
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="withCandidate">with candidate.</param>
        /// <returns>
        /// an input data source on successful completion of the check
        /// </returns>
        public IInputDataSource CheckCandidate(IConnectionDetail usingDetail, string withCandidate)
        {
            var script = GetScript(BatchProcessName.GetOperatingYear, withCandidate);
            var yearTemp = Context.GetAtom<string>(script, usingDetail);

            script = GetScript(BatchProcessName.GetCollectionType, withCandidate);
            var collectionTemp = Context.GetAtom<string>(script, usingDetail);

            script = GetScript(BatchProcessName.GetProviders, withCandidate);
            var providerIDs = Context.GetList<int>(script, usingDetail);

            var providers = Collection.Empty<ILearningProvider>();
            providerIDs.ForEach(x => providers.Add(new LearningProvider { ID = x }));

            return new InputDataSource
            {
                Name = withCandidate,
                Container = usingDetail.Container,
                DBName = usingDetail.DBName,
                DBUser = usingDetail.DBUser,
                DBPassword = usingDetail.DBPassword,
                CollectionType = collectionTemp.AsOperationType(),
                OperatingYear = yearTemp.AsOperatingYear(),
                Providers = providers.AsSafeReadOnlyList()
            };
        }

        /// <summary>
        /// Gets the provider details.
        /// </summary>
        /// <param name="usingDetail">using detail.</param>
        /// <param name="providerIDs">provider ids.</param>
        /// <returns>
        /// returns a list of enriched provider details
        /// </returns>
        public IReadOnlyCollection<IProviderDetails> GetProviderDetails(IConnectionDetail usingDetail, IReadOnlyCollection<int> providerIDs)
        {
            if (It.IsEmpty(providerIDs))
            {
                return Collection.EmptyAndReadOnly<IProviderDetails>();
            }

            var script = GetScript(BatchProcessName.GetProviderDetails);
            script = Substitute.ReplaceTokensIn(script, x => x.Replace("${providerIDs}", string.Join(",", providerIDs)));

            return Context.GetItems<ProviderDetails, IProviderDetails>(script, usingDetail, "UKPRN", "Name", "Location", "Street", "Town", "Postcode");
        }

        /// <summary>
        /// Gets the provider defaults.
        /// </summary>
        /// <param name="providerIDs">The provider ids.</param>
        /// <returns>
        /// returns a list of (not so) enriched provider details
        /// </returns>
        public IReadOnlyCollection<IProviderDetails> GetProviderDefaults(IReadOnlyCollection<int> providerIDs)
        {
            var details = Collection.Empty<IProviderDetails>();

            providerIDs.ForEach(x =>
            {
                details.Add(new ProviderDetails { UKPRN = x, Name = "(details unknown, check your token substitutions)" });
            });

            return details.AsSafeReadOnlyList();
        }

        /// <summary>
        /// Gets the learner count.
        /// </summary>
        /// <param name="usingDetail">The using detail.</param>
        /// <param name="providerID">The provider identifier.</param>
        /// <returns>the learner count for this submission</returns>
        public int GetLearnerCount(IConnectionDetail usingDetail, int providerID)
        {
            var script = GetScript(BatchProcessName.GetLearnerCountForProvider, usingDetail.DBName);
            var temp = Token.DoSecondaryPass(script, providerID);

            return Context.GetAtom<int>(temp, usingDetail);
        }

        /// <summary>
        /// Gets the script.
        /// </summary>
        /// <param name="forProcessName">for process name</param>
        /// <param name="withCandidate">with candidate.</param>
        /// <returns>
        /// the 'de' tokenised script
        /// </returns>
        public string GetScript(BatchProcessName forProcessName, string withCandidate = null)
        {
            var batch = Batches.GetBatch(forProcessName);
            var script = batch.Scripts.First();

            var failedType = !It.IsInRange(script.Type, TypeOfBatchScript.Statement);
            failedType
                .AsGuard<ArgumentException>($"script should be a statement {forProcessName}");

            return It.Has(withCandidate)
                ? script.Command.Replace(Token.ForSourceDataStore, withCandidate)
                : script.Command;
        }
    }
}
