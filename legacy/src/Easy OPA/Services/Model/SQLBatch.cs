using EasyOPA.Set;
using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// sql batch
    /// </summary>
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "Batch")]
    public sealed class SQLBatch :
        ISQLBatch
    {
        /// <summary>
        /// Gets the description.
        /// </summary>
        [DataMember]
        public string Description { get; set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        [DataMember]
        public BatchProcessName Name { get; set; }

        /// <summary>
        /// Gets the scripts.
        /// </summary>
        [DataMember]
        public CleanList<SQLBatchScript> Scripts { get; set; }

        /// <summary>
        /// Gets the operating year.
        /// </summary>
        [DataMember]
        public BatchOperatingYear OperatingYear { get; set; }

        /// <summary>
        /// Gets the scripts.
        /// </summary>
        IReadOnlyCollection<ISQLBatchScript> ISQLBatch.Scripts => Scripts.AsSafeReadOnlyList();
    }
}
