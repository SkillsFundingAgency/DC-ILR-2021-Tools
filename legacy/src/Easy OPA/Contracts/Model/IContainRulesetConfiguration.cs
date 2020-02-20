using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i contain rulebase configuration
    /// </summary>
    public interface IContainRulesetConfiguration
    {
        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> Rulebases { get; }
    }
}
