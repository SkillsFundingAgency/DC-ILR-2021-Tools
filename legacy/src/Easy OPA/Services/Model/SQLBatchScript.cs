using EasyOPA.Set;
using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// sql batch script
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "Script")]
    public sealed class SQLBatchScript :
        ISQLBatchScript
    {
        /// <summary>
        /// Gets the description.
        /// </summary>
        [DataMember]
        public string Description { get; set; }

        /// <summary>
        /// Gets the type.
        /// </summary>
        [DataMember]
        public TypeOfBatchScript Type { get; set; }

        /// <summary>
        /// Gets the command.
        /// </summary>
        [DataMember]
        public string Command { get; set; }
    }
}
