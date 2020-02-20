using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// rulebase operation types
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum TypeOfRulebaseOperation
    {
        /// <summary>
        /// not set, the default value
        /// </summary>
        NotSet,

        /// <summary>
        /// validation
        /// </summary>
        [EnumMember]
        Validation,

        /// <summary>
        /// calculation
        /// </summary>
        [EnumMember]
        Calculation,
    }
}
