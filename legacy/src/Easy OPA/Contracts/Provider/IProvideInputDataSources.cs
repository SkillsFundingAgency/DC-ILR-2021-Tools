using EasyOPA.Indirect;
using EasyOPA.Model;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide input data sources...
    /// </summary>
    public interface IProvideInputDataSources :
        IRequireComposing
    {
        /// <summary>
        /// Gets the candidates.
        /// </summary>
        /// <param name="forContext">For context.</param>
        /// <returns>
        /// returns a list of verified input data sources
        /// </returns>
        Task<IReadOnlyCollection<IInputDataSource>> GetCandidates(IConnectionDetail forContext);

        /// <summary>
        /// Gets the provider details.
        /// </summary>
        /// <param name="usingDetail">using detail.</param>
        /// <param name="providerIDs">provider ids.</param>
        /// <returns>
        /// returns a list of provider details
        /// </returns>
        IReadOnlyCollection<IProviderDetails> GetProviderDetails(IConnectionDetail usingDetail, IReadOnlyCollection<int> providerIDs);

        /// <summary>
        /// Gets the learner count.
        /// </summary>
        /// <param name="usingDetail">The using detail.</param>
        /// <param name="providerID">The provider identifier.</param>
        /// <returns>the learner count for this submission</returns>
        int GetLearnerCount(IConnectionDetail usingDetail, int providerID);
    }
}
