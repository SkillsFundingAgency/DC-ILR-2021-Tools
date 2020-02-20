using EasyOPA.Set;
using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// the rulebase configuration container
    /// </summary>
    /// <seealso cref="IRulebaseConfiguration" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class RulebaseConfiguration :
        IRulebaseConfiguration
    {
        /// <summary>
        /// Called when [deserializing].
        /// </summary>
        /// <param name="context">The context.</param>
        [OnDeserializing]
        private void OnDeserializing(StreamingContext context)
        {
            DegreeOfParallelism = 8;
        }

        /// <summary>
        /// Gets the name.
        /// name="ILR Apprenticeship Earnings Calc"
        /// </summary>
        [DataMember]
        public string Name { get; set; }

        /// <summary>
        /// Gets the opa transformation file name
        /// xslFile = "ILR Apprenticeship Earnings Calc - Input_XSLT.xsl"
        /// </summary>
        [DataMember]
        public string OPATransform { get; set; }

        /// <summary>
        /// Gets the opa configuration file name
        /// configFile="AEC_OPAConfigILR_1718.xml"
        /// </summary>
        [DataMember]
        public string OPAConfiguration { get; set; }

        /// <summary>
        /// Gets the collection (type).
        /// </summary>
        [DataMember]
        public TypeOfCollection Collection { get; set; }

        /// <summary>
        /// Gets the (rulebase) operating year.
        /// year="1718" <= "OY_1718"
        /// </summary>
        [DataMember]
        public BatchOperatingYear OperatingYear { get; set; }

        /// <summary>
        /// Gets the post run routines.
        /// <postRunSP name = "[Rulebase].[AEC_PivotTemporals_LearningDelivery]" timeout="600" />
        /// <postRunSP name = "[Rulebase].[AEC_PivotTemporals_ApprenticeshipPriceEpisode]" timeout="600" />
        /// </summary>
        [DataMember]
        public CleanList<SQLBatchScript> PostRunRoutines { get; set; }

        /// <summary>
        /// Gets the pre run routines.
        /// <preRunSP name = "[dbo].[TransformInputToValid]" timeout="600" />
        /// <preRunSP name = "[Rulebase].[AEC_Insert_Cases]" timeout="600" />
        /// </summary>
        [DataMember]
        public CleanList<SQLBatchScript> PreRunRoutines { get; set; }

        /// <summary>
        /// Gets or sets the insert count (script).
        /// </summary>
        [DataMember]
        public SQLBatchScript InsertCount { get; set; }

        /// <summary>
        /// Gets the (rulebase) short name.
        /// shortName="AEC"
        /// </summary>
        [DataMember]
        public string ShortName { get; set; }

        /// <summary>
        /// Gets or sets the dependency.
        /// some rulebases have a dependency on the results from another rulebase.
        /// </summary>
        [DataMember]
        public string Dependency { get; set; }

        /// <summary>
        /// Gets the execution type.
        /// </summary>
        [DataMember]
        public TypeOfRulebaseExecution ExecutionType { get; set; }

        /// <summary>
        /// Gets the type of the operation (validation, calculation)
        /// </summary>
        [DataMember]
        public TypeOfRulebaseOperation OperationType { get; set; }

        /// <summary>
        /// Gets the degree of parallelism.
        /// defaults to 8...
        /// </summary>
        [DataMember]
        public int DegreeOfParallelism { get; set; }

        /// <summary>
        /// Gets the post run routines.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> IRulebaseConfiguration.PostRunRoutines => PostRunRoutines.AsSafeReadOnlyList();

        /// <summary>
        /// Gets the pre run routines.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> IRulebaseConfiguration.PreRunRoutines => PreRunRoutines.AsSafeReadOnlyList();

        /// <summary>
        /// Gets the insert count (script).
        /// </summary>
        ISQLBatchScript IRulebaseConfiguration.InsertCount => InsertCount;

        /// <summary>
        /// Gets a value indicating whether this instance is experimental.
        /// </summary>
        public bool IsExperimental { get; set; }

        /// <summary>
        /// Gets the pointer to (the) zip (file).
        /// </summary>
        public string PointerToZip { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected for processing.
        /// </summary>
        public bool IsSelectedForProcessing { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is enabled for selection.
        /// </summary>
        public bool IsEnabledForSelection { get; set; } = true;

        /// <summary>
        /// Sets...
        /// </summary>
        /// <param name="isExperimental">if set to <c>true</c> [is experimental].</param>
        /// <param name="andPointerToZip">and (the) pointer to (the) zip (file).</param>
        public void Set(bool isExperimental, string andPointerToZip)
        {
            IsExperimental = isExperimental;
            PointerToZip = andPointerToZip;
        }
    }
}
