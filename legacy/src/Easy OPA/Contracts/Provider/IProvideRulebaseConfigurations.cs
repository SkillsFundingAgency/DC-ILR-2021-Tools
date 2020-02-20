using EasyOPA.Indirect;
using EasyOPA.Model;
using System.Collections.Generic;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide rulebase configurations
    /// </summary>
    public interface IProvideRulebaseConfigurations //:
        //IRequireComposing
    {
        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> Rulebases { get; }

        /// <summary>
        /// Gets the opa configuration for.
        /// </summary>
        /// <param name="thisRulebase">this rulebase.</param>
        /// <returns>the cleansed and detokenised configuration file</returns>
        string GetOPAConfigurationFor(IRulebaseConfiguration thisRulebase);

        /// <summary>
        /// Gets the opa transformation path for.
        /// </summary>
        /// <param name="thisRulebase">this rulebase.</param>
        /// <returns>the path to the transformation file</returns>
        string GetOPATransformationPathFor(IRulebaseConfiguration thisRulebase);
    }
}
