using EasyOPA.Model;
using System.Collections.Generic;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create session configurations
    /// </summary>
    public interface ICreateSessionConfigurations
    {
        /// <summary>
        /// Creates a run configuration...
        /// </summary>
        /// <param name="withRulesToRun">with rules to run.</param>
        /// <param name="andInputSource">and input source.</param>
        /// <returns>
        /// a session configuration
        /// </returns>
        IContainSessionConfiguration Create(
            IReadOnlyCollection<IRulebaseConfiguration> withRulesToRun,
            IInputDataSource andInputSource);
    }
}
