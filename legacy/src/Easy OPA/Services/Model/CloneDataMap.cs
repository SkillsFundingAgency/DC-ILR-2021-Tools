using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "DataCloneConfiguration")]
    public sealed class CloneDataMap :
        IMapClonedData
    {
        [DataMember]
        public CleanList<CloneEntityMap> TableMappings { get; set; }

        IReadOnlyCollection<IMapCloneEntityDetails> IMapClonedData.Entities => TableMappings.AsSafeReadOnlyList();
    }

    // note: a codge class for shonky XML
    [DataContract(Namespace = "", Name = "CopyCatConfig")]
    public sealed class ProductionCloneDataMap :
        IMapClonedData
    {
        // note: not used...
        [DataMember(Order = 1)]
        public string SourceConnectionString { get; set; }

        // note: not used...
        [DataMember(Order = 2)]
        public string DestinationConnectionString { get; set; }

        [DataMember(Order = 3)]
        public NamelessCleanList<ProductionCloneEntityMap> TableMappings { get; set; }

        IReadOnlyCollection<IMapCloneEntityDetails> IMapClonedData.Entities => TableMappings.AsSafeReadOnlyList();
    }
}
