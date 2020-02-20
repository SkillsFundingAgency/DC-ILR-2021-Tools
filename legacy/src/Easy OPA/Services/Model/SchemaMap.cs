using EasyOPA.Set;
using ESFA.Common;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// schema map
    /// </summary>
    /// <seealso cref="ISchemaMap" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class SchemaMap : ISchemaMap
    {
        /// <summary>
        /// Gets the bulk load (schema file name).
        /// </summary>
        [DataMember]
        public string BulkLoad { get; set; }

        /// <summary>
        /// Gets the bulk export (template file name).
        /// </summary>
        [DataMember]
        public string BulkExport { get; set; }

        /// <summary>
        /// Gets the collection (type).
        /// </summary>
        [DataMember]
        public TypeOfCollection Collection { get; set; }

        /// <summary>
        /// Gets the message (schema file name).
        /// </summary>
        [DataMember]
        public string Message { get; set; }

        /// <summary>
        /// Gets the (message) namespace.
        /// </summary>
        [DataMember]
        public string Namespace { get; set; }

        /// <summary>
        /// Gets the (collection) year.
        /// </summary>
        [DataMember]
        public BatchOperatingYear Year { get; set; }

        /// <summary>
        /// Gets or sets the period start date.
        /// </summary>
        [DataMember]
        public string PeriodStartDate { get; set; }
    }
}
