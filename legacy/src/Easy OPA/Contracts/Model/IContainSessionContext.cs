using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// i contain session context
    /// </summary>
    public interface IContainSessionContext
    {
        /// <summary>
        /// Gets the connection details for master.
        /// </summary>
        IConnectionDetail Master { get; }

        /// <summary>
        /// Gets the 'Intrajob' (connection details)
        /// </summary>
        IConnectionDetail ProcessingLocation { get; }

        /// <summary>
        /// Gets the data source location (connection details)
        /// </summary>
        IConnectionDetail SourceLocation { get; }

        /// <summary>
        /// Gets the connection details for the 'results destination' (data store).
        /// user selected, so this maybe the 'source' or 'data exchange' data store
        /// </summary>
        IConnectionDetail ResultsDestination { get; }

        /// <summary>
        /// Gets the year.
        /// </summary>
        BatchOperatingYear Year { get; }

        /// <summary>
        /// Gets the run mode.
        /// </summary>
        TypeOfRunMode RunMode { get; }

        /// <summary>
        /// Gets a value indicating whether [using source for results].
        /// </summary>
        bool UsingSourceForResults { get; }

        /// <summary>
        /// Gets a value indicating whether [deposit rulebase artefacts].
        /// </summary>
        bool DepositRulebaseArtefacts { get; }

        /// <summary>
        /// Gets the return period.
        /// </summary>
        ReturnPeriod ReturnPeriod { get; }
    }
}
