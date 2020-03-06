using EasyOPA.Set;
using EasyOPA.Utility;
using XML2SQL;

namespace EasyOPA.Model
{
    /// <summary>
    /// the connection context provider class
    /// this class will not be exported
    /// it will be provided through a factory class
    /// </summary>
    /// <seealso cref="IContainSessionContext" />
    public sealed class SessionContextContainer :
        IContainSessionContext
    {
        /// <summary>
        /// Gets the name of the Intrajob (data store).
        /// </summary>
        public static string IntrajobName => "EOPA_DB";

        /// <summary>
        /// Gets the connection details for master.
        /// </summary>
        public IConnectionDetail Master { get; set; }

        /// <summary>
        /// Gets the connection details for 'intrajob'.
        /// </summary>
        public IConnectionDetail ProcessingLocation { get; set; }

        /// <summary>
        /// Gets the data source.
        /// </summary>
        public IConnectionDetail SourceLocation { get; set; }

        /// <summary>
        /// Gets the connection details for the data store.
        /// </summary>
        public IConnectionDetail ResultsDestination { get; set; }

        /// <summary>
        /// Gets the name of the data exchange (data store).
        /// </summary>
        public string DataExchangeName => "EOPA_DB";

        /// <summary>
        /// Gets the year.
        /// </summary>
        public BatchOperatingYear Year { get; set; }

        /// <summary>
        /// Gets or sets the run mode.
        /// </summary>
        public TypeOfRunMode RunMode { get; set; }

        /// <summary>
        /// Gets a value indicating whether [using source for results].
        /// </summary>
        public bool UsingSourceForResults { get; set; }

        /// <summary>
        /// Gets a value indicating whether [deposit rulebase artefacts].
        /// </summary>
        public bool DepositRulebaseArtefacts { get; set; }

        /// <summary>
        /// Gets the return period.
        /// </summary>
        public ReturnPeriod ReturnPeriod { get; set; }
    }
}
