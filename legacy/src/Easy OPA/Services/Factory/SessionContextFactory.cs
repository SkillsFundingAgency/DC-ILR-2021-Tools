using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    /// connection context provider factory
    /// </summary>
    /// <seealso cref="ICreateSessionContexts" />
    [Shared]
    [Export(typeof(ICreateSessionContexts))]
    public sealed class SessionContextFactory :
        ICreateSessionContexts
    {
        /// <summary>
        /// Creates (a connection detail) for...
        /// </summary>
        /// <param name="thisInstance">this instance.</param>
        /// <param name="thisSource">this source.</param>
        /// <returns>a connection string</returns>
        public IConnectionDetail CreateFor(string thisInstance, string thisSource, string thisUser, string thisPassword)
        {
            // connection strings are somewhat of a mystery, sometimes....
            // Provider=sqloledb;Server={usingInstance};Database={andDataSource};Integrated Security=SSPI
            // Integrated Security=true
            // Integrated Security=SSPI
            // Trusted_Connection=true
            if(string.IsNullOrEmpty(thisUser) || string.IsNullOrEmpty(thisPassword))
            {
                return new ConnectionDetail
                {
                    Name = thisSource,
                    Container = thisInstance,
                    DBUser = thisUser,
                    DBPassword = thisPassword,
                    SQLDetail = $"Data Source={thisInstance};Initial Catalog={thisSource};Integrated Security=true;",
                    COMDetail = $"Provider=sqloledb;Server={thisInstance};Database={thisSource};Integrated Security=SSPI"
                };
            }
            return new ConnectionDetail
            {
                Name = thisSource,
                Container = thisInstance,
                DBUser = thisUser,
                DBPassword = thisPassword,
                SQLDetail = $"Server=tcp:{thisInstance},1433;Initial Catalog={thisSource};Persist Security Info=False;User ID={thisUser};Password={thisPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
                COMDetail = $"Provider=sqloledb;Server={thisInstance};Database={thisSource};User Id={thisUser};Password={thisPassword}"
            };
        }

        /// <summary>
        /// Connects to master.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <returns>
        /// a connection detail for the 'master' data source
        /// </returns>
        public IConnectionDetail ConnectionToMaster(string onInstance, string thisUser, string thisPassword)
        {
            return CreateFor(onInstance, "EasyOpa", thisUser, thisPassword);
        }

        /// <summary>
        /// Connects to (a) source.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <param name="withName">with (the) Name</param>
        /// <returns>
        /// a connection detail for the data source
        /// </returns>
        public IConnectionDetail ConnectionToSource(string onInstance, string withName, string thisUser, string thisPassword)
        {
            return CreateFor(onInstance, withName, thisUser, thisPassword);
        }

        /// <summary>
        /// Creates a context provider...
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <param name="forDataSource">for data source.</param>
        /// <param name="usingSourceForResults">if set to <c>true</c> [using source for results].</param>
        /// <param name="depositArtefacts">if set to <c>true</c> [deposit artefacts].</param>
        /// <param name="returnPeriod">The return period.</param>
        /// <returns>
        /// a connection context provider
        /// </returns>
        public IContainSessionContext Create(string onInstance, string thisUser, string thisPassword, IInputDataSource forDataSource, bool runMode, bool usingSourceForResults, bool depositArtefacts, ReturnPeriod returnPeriod)
        {
            var sourceLocation = CreateFor(onInstance, forDataSource.Name, thisUser, thisPassword);

            var provider = new SessionContextContainer
            {
                Year = forDataSource.OperatingYear,
                Master = CreateFor(onInstance, "master", thisUser, thisPassword),
                SourceLocation = sourceLocation,
                ProcessingLocation = CreateFor(onInstance, SessionContextContainer.IntrajobName, thisUser, thisPassword),
                RunMode = runMode ? TypeOfRunMode.Lite : TypeOfRunMode.Full,
                UsingSourceForResults = usingSourceForResults,
                DepositRulebaseArtefacts = depositArtefacts,
                ReturnPeriod = returnPeriod
            };

            provider.ResultsDestination = usingSourceForResults
                ? sourceLocation
                : CreateFor(onInstance, provider.DataExchangeName, thisUser, thisPassword);

            return provider;
        }
    }
}
