using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// rule bases probably need to be sub-divided by 'collection type'
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum TypeOfCollection
    {
        /// <summary>
        /// not set, the default (expected to cause failures)
        /// </summary>
        [EnumMember]
        NotSet,

        /// <summary>
        /// ilr, the only currenlty supported collection type for the OPA wrapper
        /// </summary>
        [EnumMember]
        ILR,

        /// <summary>
        /// NCS <= just a suggestion of what might be
        /// </summary>
        [EnumMember]
        NCS
    }
}
