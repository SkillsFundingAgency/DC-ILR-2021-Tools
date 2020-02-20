using ESFA.Common;
using System;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// batch operating year, as batch configuration is likely to change subtlely each year...
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum BatchOperatingYear
    {
        /// <summary>
        /// not set, the default value
        /// </summary>
        NotSet,

        /// <summary>
        /// All for general scripts not configured for any particular year
        /// </summary>
        [EnumMember]
        All,

        /// <summary>
        /// operating year - 16/17
        /// </summary>
        [EnumMember]
        OY_1617,

        /// <summary>
        /// operating year - 17/18
        /// </summary>
        [EnumMember]
        OY_1718,

        /// <summary>
        /// operating year - 18/19
        /// </summary>
        [EnumMember]
        OY_1819,

        /// <summary>
        /// operating year - 19/20
        /// </summary>
        [EnumMember]
        OY_1920,

        /// <summary>
        /// operating year - 20/21
        /// </summary>
        [EnumMember]
        OY_2021
    }
}
