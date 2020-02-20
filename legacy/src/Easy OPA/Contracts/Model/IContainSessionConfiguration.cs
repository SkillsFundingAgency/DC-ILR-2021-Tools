using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i carry run configuration
    /// </summary>
    public interface IContainSessionConfiguration
    {
        /// <summary>
        /// Gets the rules to run.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> RulesToRun { get; }

        /// <summary>
        /// Gets or sets the input data source.
        /// </summary>
        IInputDataSource InputDataSource { get; }
    }
}
