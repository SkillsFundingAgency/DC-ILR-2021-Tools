using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// session configuration
    /// this class is not exported
    /// it will be provided through a factory class
    /// </summary>
    /// <seealso cref="IContainSessionConfiguration" />
    public sealed class SessionConfiguration :
        IContainSessionConfiguration
    {
        /// <summary>
        /// Gets the rules to run.
        /// </summary>
        public IReadOnlyCollection<IRulebaseConfiguration> RulesToRun { get; set; }

        /// <summary>
        /// Gets the input data source.
        /// </summary>
        public IInputDataSource InputDataSource { get; set; }
    }
}
