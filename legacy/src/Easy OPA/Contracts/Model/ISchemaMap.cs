using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// i schema map
    /// </summary>
    public interface ISchemaMap
    {
        /// <summary>
        /// Gets the bulk load (schema file name).
        /// </summary>
        string BulkLoad { get; }

        /// <summary>
        /// Gets the bulk export (template file name).
        /// </summary>
        string BulkExport { get; }

        /// <summary>
        /// Gets the collection (type).
        /// </summary>
        TypeOfCollection Collection { get; }

        /// <summary>
        /// Gets the message (schema file name).
        /// </summary>
        string Message { get; }

        /// <summary>
        /// Gets the (message) namespace.
        /// </summary>
        string Namespace { get; }

        /// <summary>
        /// Gets the (collection) year.
        /// </summary>
        BatchOperatingYear Year { get; }

        /// <summary>
        /// Gets the period start date.
        /// </summary>
        string PeriodStartDate { get; }
    }
}
