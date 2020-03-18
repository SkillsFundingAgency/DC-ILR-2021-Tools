using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "TableMapping")]
    public sealed class CloneEntityMap :
        IMapCloneEntityDetails
    {
        [DataMember]
        public string Master { get; set; }

        [DataMember]
        public string Target { get; set; }

        [DataMember]
        public CleanList<CloneAttributeMap> ColumnMappings { get; set; }

        IReadOnlyCollection<IMapCloneAttributeDetails> IMapCloneEntityDetails.Attributes => ColumnMappings.AsSafeReadOnlyList();
    }

    // note: a codge class for shonky XML
    [DataContract(Namespace = "", Name = "TableMapping")]
    public sealed class ProductionCloneEntityMap :
        IMapCloneEntityDetails
    {
        [DataMember(Name = "Source", Order = 1)]
        public string Master { get; set; }

        [DataMember(Name = "Destination", Order = 2)]
        public string Target { get; set; }

        // note: mispelt and not used...
        [DataMember(Name = "Oridinal", Order = 3)]
        public string Ordinal { get; set; }

        [DataMember(Order = 4)]
        public NamelessCleanList<ProductionCloneAttributeMap> ColumnMappings { get; set; }

        IReadOnlyCollection<IMapCloneAttributeDetails> IMapCloneEntityDetails.Attributes => ColumnMappings.AsSafeReadOnlyList();
    }
}
