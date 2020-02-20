using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// sql batch configuration is the instantiation of the xml file "sqlbatch.cfg"
    /// </summary>
    /// <seealso cref="IContainSQLBatches" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace, Name = "BatchConfiguration")]
    public sealed class SQLBatchConfiguration :
        IContainSQLBatches
    {
        /// <summary>
        /// Gets the batches.
        /// </summary>
        [DataMember]
        public CleanList<SQLBatch> Batches { get; set; }

        /// <summary>
        /// Gets the batches.
        /// </summary>
        IReadOnlyCollection<ISQLBatch> IContainSQLBatches.Batches => Batches.AsSafeReadOnlyList();
    }
}
