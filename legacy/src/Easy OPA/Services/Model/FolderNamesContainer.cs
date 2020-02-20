using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// folder names container
    /// </summary>
    /// <seealso cref="IContainFolderNames" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class FolderNamesContainer :
        IContainFolderNames
    {
        /// <summary>
        /// Gets the opa configuration folder name
        /// </summary>
        [DataMember]
        public string OPAConfig { get; set; }

        /// <summary>
        /// Gets the opa rules folder name.
        /// </summary>
        [DataMember]
        public string OPARules { get; set; }
    }
}
