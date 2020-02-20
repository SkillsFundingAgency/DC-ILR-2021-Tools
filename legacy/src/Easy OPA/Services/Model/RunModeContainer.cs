using EasyOPA.Set;
using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// the run facility implementation
    /// </summary>
    /// <seealso cref="IContainRunModeDetail" />
    [DataContract(Name= "RunMode", Namespace = ESFAConstant.ModelItemNamespace)]
    public class RunModeContainer : IContainRunModeDetail
    {
        [DataMember]
        public TypeOfRunMode Name { get; set; }

        [DataMember]
        public string DestinationMap { get; set; }

        [DataMember]
        public string Rulebase { get; set; }

        [DataMember]
        public string SourceMap { get; set; }

        [DataMember]
        public string SQLBatch { get; set; }

        [DataMember]
        public string TokenMap { get; set; }
    }
}
