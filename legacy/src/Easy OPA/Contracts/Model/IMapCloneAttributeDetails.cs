using System.Data.SqlClient;

namespace EasyOPA.Model
{
    /// <summary>
    /// i map clone (entity) attribute details
    /// </summary>
    public interface IMapCloneAttributeDetails
    {
        /// <summary>
        /// Gets the master (source)
        /// </summary>
        string Master { get; }

        /// <summary>
        /// Gets the target (destination)
        /// </summary>
        string Target { get; }
    }

    /// <summary>
    /// a clone attribute mapping helper
    /// </summary>
    public static class CloneAttributeMappingHelper
    {
        public static SqlBulkCopyColumnMapping AsBulkCopyColumnMapping(this IMapCloneAttributeDetails column)
        {
            return new SqlBulkCopyColumnMapping(column.Master, column.Target);
        }
    }
}