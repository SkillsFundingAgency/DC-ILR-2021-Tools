using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// locations container
    /// </summary>
    /// <seealso cref="IContainLocations" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class LocationsContainer :
        IContainLocations
    {
        /// <summary>
        /// Gets the production location
        /// </summary>
        [DataMember]
        public string Production { get; set; }

        /// <summary>
        /// Gets the experimental location
        /// </summary>
        [DataMember]
        public string Experimental { get; set; }
    }
}
