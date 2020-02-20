using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// batch script types
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum TypeOfBatchScript
    {
        /// <summary>
        /// not set, the default value
        /// </summary>
        NotSet,

        /// <summary>
        /// ignored, a way of initiating the configuration but not having it executed
        /// </summary>
        [EnumMember]
        Ignored,

        /// <summary>
        /// a file
        /// </summary>
        [EnumMember]
        File,

        /// <summary>
        /// a statement
        /// </summary>
        [EnumMember]
        Statement,
    }
}
