using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide schema configurations
    /// </summary>
    public interface IProvideSchemaConfigurations
    {
        /// <summary>
        /// Gets the schema.
        /// </summary>
        /// <param name="forThisNameSpace">For this name space.</param>
        /// <returns>a schema map</returns>
        ISchemaMap GetSchema(string forThisNameSpace);

        /// <summary>
        /// Gets the schema.
        /// </summary>
        /// <param name="forThisYear">For this year.</param>
        /// <returns>a schema map</returns>
        ISchemaMap GetSchema(BatchOperatingYear forThisYear);
    }
}
