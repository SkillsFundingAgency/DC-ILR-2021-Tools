using EasyOPA.Model;

namespace EasyOPA.Service
{
    /// <summary>
    /// i run rulebases
    /// </summary>
    public interface IRunRulebases
    {
        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="thisRule">this rule.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>
        /// the number of rulebase artefacts generated
        /// </returns>
        int Run(IRulebaseConfiguration thisRule, IContainSessionContext inContext);
    }
}
