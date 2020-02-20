using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Set
{
    /// <summary>
    /// batch process names
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public enum BatchProcessName
    {
        /// <summary>
        /// not set, the default value
        /// </summary>
        NotSet,

        /// <summary>
        /// The experimental items
        /// not 'data contracted' as it should never 'come in' from a configuration file
        /// </summary>
        ExperimentalItems,

        /// <summary>
        /// get operating year
        /// </summary>
        [EnumMember]
        GetOperatingYear,

        /// <summary>
        /// get collection type
        /// </summary>
        [EnumMember]
        GetCollectionType,

        /// <summary>
        /// get input source candidates
        /// </summary>
        [EnumMember]
        GetInputSourceCandidates,

        /// <summary>
        /// copy to processing data store
        /// </summary>
        [EnumMember]
        CopyToProcessingDataStore,

        /// <summary>
        /// The copy to results data store
        /// </summary>
        [EnumMember]
        CopyToResultsDataStore,

        /// <summary>
        /// transform input to valid (and invalid)
        /// </summary>
        [EnumMember]
        TransformToValid,

        /// <summary>
        /// build processing data store
        /// </summary>
        [EnumMember]
        BuildProcessingDataStore,

        /// <summary>
        /// build results data store
        /// </summary>
        [EnumMember]
        BuildResultsDataStore,

        /// <summary>
        /// export source data to ilr file
        /// </summary>
        [EnumMember]
        ExportSourceDataToILRFile,

        /// <summary>
        /// get (the) providers
        /// </summary>
        [EnumMember]
        GetProviders,

        /// <summary>
        /// build source data store
        /// </summary>
        [EnumMember]
        BuildSourceDataStore,

        /// <summary>
        /// cleanse results data store
        /// </summary>
        [EnumMember]
        CleanseResultsDataStore,

        /// <summary>
        /// get provider details
        /// </summary>
        [EnumMember]
        GetProviderDetails,

        /// <summary>
        /// get learner count for provider
        /// </summary>
        [EnumMember]
        GetLearnerCountForProvider,

        /// <summary>
        /// cleanse processing data store
        /// </summary>
        [EnumMember]
        CleanseProcessingDataStore,
    }
}
