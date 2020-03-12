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
        public IConnectionDetail CreateFor(string thisInstance, string thisSource)
        {
            // connection strings are somewhat of a mystery, sometimes....
            // Provider=sqloledb;Server={usingInstance};Database={andDataSource};Integrated Security=SSPI
            // Integrated Security=true
            // Integrated Security=SSPI
            // Trusted_Connection=true
            return new ConnectionDetail
            {
                Name = thisSource,
                Container = thisInstance,
                //SQLDetail = $"Data Source=crossdatabasetest.database.windows.net;Initial Catalog=eopatest;User ID=sqladmin;Password=Pa$$w0rd;Integrated Security=true;",
                SQLDetail = $"Server=tcp:crossdatabasetest.database.windows.net,1433;Initial Catalog=EOPA_DB;Persist Security Info=False;User ID=sqladmin;Password=Pa$$w0rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
                COMDetail = $"Provider=sqloledb;Server=crossdatabasetest.database.windows.net;Database=EOPA_DB;User Id=sqladmin;Password=Pa$$w0rd"
                //COMDetail = $"Server=tcp:crossdatabasetest.database.windows.net,1433;Initial Catalog=eopatest;Persist Security Info=False;User ID=sqladmin;Password=Pa$$w0rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
            };
        }

        /// <summary>
        /// Connects to master.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <returns>
        /// a connection detail for the 'master' data source
        /// </returns>
        public IConnectionDetail ConnectionToMaster(string onInstance)
        {
            return CreateFor(onInstance, "master");
        }

        /// <summary>
        /// Connects to (a) source.
        /// </summary>
        /// <param name="onInstance">on instance.</param>
        /// <param name="withName">with (the) Name</param>
        /// <returns>
        /// a connection detail for the data source
        /// </returns>
        public IConnectionDetail ConnectionToSource(string onInstance, string withName)
        {
            return CreateFor(onInstance, withName);
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
        public IContainSessionContext Create(string onInstance, IInputDataSource forDataSource, bool runMode, bool usingSourceForResults, bool depositArtefacts, ReturnPeriod returnPeriod)
        {
            var sourceLocation = CreateFor(onInstance, forDataSource.Name);

            var provider = new SessionContextContainer
            {
                Year = forDataSource.OperatingYear,
                Master = CreateFor(onInstance, "master"),
                SourceLocation = sourceLocation,
                ProcessingLocation = CreateFor(onInstance, SessionContextContainer.IntrajobName),
                RunMode = runMode ? TypeOfRunMode.Lite : TypeOfRunMode.Full,
                UsingSourceForResults = usingSourceForResults,
                DepositRulebaseArtefacts = depositArtefacts,
                ReturnPeriod = returnPeriod
            };

            provider.ResultsDestination = usingSourceForResults
                ? sourceLocation
                : CreateFor(onInstance, provider.DataExchangeName);

            return provider;
        }
    }
}
