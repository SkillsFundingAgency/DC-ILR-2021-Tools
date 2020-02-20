using EasyOPA.Set;
using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i contain rulebase configuration
    /// </summary>
    public interface IRulebaseConfiguration :
        ICanBeSelectedForProcessing
    {
        /// <summary>
        /// Gets the name.
        /// </summary>
        string Name { get; }

        /// <summary>
        /// Gets the opa transformation file name
        /// </summary>
        string OPATransform { get; }

        /// <summary>
        /// Gets the opa configuration file name
        /// </summary>
        string OPAConfiguration { get; }

        /// <summary>
        /// Gets the (rulebase) operating year.
        /// year="1718" <= "OY_1718"
        /// </summary>
        BatchOperatingYear OperatingYear { get; }

        /// <summary>
        /// Gets the collection (type).
        /// </summary>
        TypeOfCollection Collection { get; }

        /// <summary>
        /// Gets the execution type.
        /// </summary>
        TypeOfRulebaseExecution ExecutionType { get; }

        /// <summary>
        /// Gets the type of the operation (validation, calculation)
        /// </summary>
        TypeOfRulebaseOperation OperationType { get; }

        /// <summary>
        /// Gets the post run routines.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> PostRunRoutines { get; }

        /// <summary>
        /// Gets the pre run routines.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> PreRunRoutines { get; }

        /// <summary>
        /// Gets the insert count (script).
        /// </summary>
        ISQLBatchScript InsertCount { get; }

        /// <summary>
        /// Gets the (rulebase) short name.
        /// </summary>
        string ShortName { get; }

        /// <summary>
        /// Gets or sets the dependency.
        /// some rulebases have a dependency on the results from another rulebase.
        /// </summary>
        string Dependency { get; }

        /// <summary>
        /// Gets the degree of parallelism.
        /// defaults to 8...
        /// </summary>
        int DegreeOfParallelism { get; }

        /// <summary>
        /// Gets a value indicating whether this instance is experimental.
        /// </summary>
        bool IsExperimental { get; }

        /// <summary>
        /// Gets the pointer to (the) zip (file).
        /// </summary>
        string PointerToZip { get; }
    }
}
