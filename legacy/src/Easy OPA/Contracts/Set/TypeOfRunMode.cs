using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// the run facility
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum TypeOfRunMode
    {
        /// <summary>
        /// full
        /// </summary>
        [EnumMember]
        Full,

        /// <summary>
        /// lite
        /// </summary>
        [EnumMember]
        Lite
    };
}
