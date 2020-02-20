using EasyOPA.Model;
using System.Collections.Generic;
using System.Composition;
using Tiny.Framework.Utilities;

namespace EasyOPA.Factory
{
    /// <summary>
    /// session configuration factory
    /// </summary>
    /// <seealso cref="ICreateSessionConfigurations" />
    [Shared]
    [Export(typeof(ICreateSessionConfigurations))]
    public sealed class SessionConfigurationFactory :
        ICreateSessionConfigurations
    {
        /// <summary>
        /// Creates a run configuration...
        /// </summary>
        /// <param name="withRulesToRun">with rules to run.</param>
        /// <param name="andInputSource">and input source.</param>
        /// <returns>
        /// a session configuration
        /// </returns>
        public IContainSessionConfiguration Create(IReadOnlyCollection<IRulebaseConfiguration> withRulesToRun, IInputDataSource andInputSource)
        {
            return new SessionConfiguration
            {
                RulesToRun = withRulesToRun.AsSafeReadOnlyList(),
                InputDataSource = andInputSource
            };
        }
    }
}
