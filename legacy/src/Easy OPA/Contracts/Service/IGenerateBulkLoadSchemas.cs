using EasyOPA.Model;
using System;
using System.Threading.Tasks;

namespace EasyOPA.Service
{
    /// <summary>
    /// i generate bulk load schemas
    /// </summary>
    public interface IGenerateBulkLoadSchemas
    {
        /// <summary>
        /// Generates the schema.
        /// </summary>
        /// <param name="forMessageNamespace">for message namespace.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="andExecuteBulkload">and execute (a) bulk load</param>
        /// <returns>the schema map sued to generate the data source</returns>
        Task<ISchemaMap> Generate(string forMessageNamespace, IConnectionDetail inContext, Action<IConnectionDetail, string, bool> andExecuteBulkload);
    }
}
