using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace EasyOPA.Model
{
    /// <summary>
    /// schema configuration is the instantiation of the xml file "schemamap.cfg"
    /// </summary>
    /// <seealso cref="ISchemaConfiguration" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class SchemaConfiguration :
        ISchemaConfiguration
    {
        /// <summary>
        /// Gets the maps.
        /// </summary>
        [DataMember]
        public CleanList<SchemaMap> Maps { get; set; }

        /// <summary>
        /// Gets the maps.
        /// </summary>
        IReadOnlyCollection<ISchemaMap> ISchemaConfiguration.Maps => Maps;
    }
}
