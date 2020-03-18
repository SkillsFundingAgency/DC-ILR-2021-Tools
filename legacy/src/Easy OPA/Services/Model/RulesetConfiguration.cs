using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// ruleset configuration is the instantiation of the xml file "rulebase.cfg"
    /// </summary>
    /// <seealso cref="IContainRulesetConfiguration" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class RulesetConfiguration :
        IContainRulesetConfiguration
    {
        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        [DataMember]
        public CleanList<RulebaseConfiguration> Rulebases { get; set; }

        /// <summary>
        /// Gets the rulebases.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> IContainRulesetConfiguration.Rulebases => Rulebases.AsSafeReadOnlyList();
    }
}
