using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// token subsitution container
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class TokenSubstitute :
        ITokenSubstitute
    {
        /// <summary>
        /// Gets  the token value.
        /// </summary>
        [DataMember]
        public string TokenValue { get; set; }

        /// <summary>
        /// Gets the substitute.
        /// </summary>
        [DataMember]
        public string Substitute { get; set; }
    }
}
