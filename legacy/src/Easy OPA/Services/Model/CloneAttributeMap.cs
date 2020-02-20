using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "ColumnMapping")]
    public sealed class CloneAttributeMap :
        IMapCloneAttributeDetails
    {
        [DataMember]
        public string Master { get; set; }

        [DataMember]
        public string Target { get; set; }
    }

    // note: a codge class for shonky XML
    [DataContract(Namespace = "", Name = "ColumnMapping")]
    public sealed class ProductionCloneAttributeMap :
        IMapCloneAttributeDetails
    {
        [DataMember(Name = "Source", Order = 1)]
        public string Master { get; set; }

        [DataMember(Name = "Destination", Order = 2)]
        public string Target { get; set; }
    }
}