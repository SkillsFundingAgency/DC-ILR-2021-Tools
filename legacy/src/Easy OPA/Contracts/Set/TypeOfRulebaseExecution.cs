using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// type of rulebase execution
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum TypeOfRulebaseExecution
    {
        /// <summary>
        /// not set, the default (only see this if an error has occrued)
        /// </summary>
        NotSet,

        /// <summary>
        /// OPA, a full OPA rule
        /// </summary>
        [EnumMember]
        OPA,

        /// <summary>
        /// SQL only...
        /// </summary>
        [EnumMember]
        SQLOnly
    }
}
