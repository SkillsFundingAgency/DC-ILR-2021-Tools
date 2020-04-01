using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create session contexts
    /// </summary>
    public interface ICreateSessionContexts
    {
        /// <summary>
        /// Connects to master.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <returns>a connection detail for the 'master' data source</returns>
        IConnectionDetail ConnectionToMaster(string onInstance, string withName, string thisUser, string thisPassword);

        /// <summary>
        /// Connects to (a) source.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <param name="withName">with (the) Name</param>
        /// <returns>a connection detail for the data source</returns>
        IConnectionDetail ConnectionToSource(string onInstance, string withName, string thisUser, string thisPassword);

        /// <summary>
        /// Creates a context provider...
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <param name="forDataSource">for data source.</param>
        /// <param name="runMode">if set to <c>true</c> [run mode].</param>
        /// <param name="usingSourceForResults">if set to <c>true</c> [using source for results].</param>
        /// <param name="depositArtefacts">if set to <c>true</c> [deposit artefacts].</param>
        /// <param name="returnPeriod">The return period.</param>
        /// <returns>
        /// a connection context provider
        /// </returns>
        IContainSessionContext Create(string onInstance, string thisUser, string thisPassword, IInputDataSource forDataSource, bool runMode, bool usingSourceForResults, bool depositArtefacts, ReturnPeriod returnPeriod);
    }
}
