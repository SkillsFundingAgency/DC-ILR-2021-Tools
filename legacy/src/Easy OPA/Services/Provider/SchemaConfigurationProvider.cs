using EasyOPA.Model;
using EasyOPA.Set;
using ESFA.Common.Abstract;
using System;
using System.Composition;
using System.IO;
using System.Linq;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// schema configuration provider
    /// </summary>
    /// <seealso cref="FileConfigurationHostBase{SchemaConfiguration, ISchemaConfiguration}" />
    /// <seealso cref="IProvideSchemaConfigurations" />
    [Shared]
    [Export(typeof(IProvideSchemaConfigurations))]
    public sealed class SchemaConfigurationProvider :
        FileConfigurationHostBase<SchemaConfiguration, ISchemaConfiguration>,
        IProvideSchemaConfigurations
    {
        /// <summary>
        /// Performs the health check.
        /// </summary>
        public override void PerformHealthCheck()
        {
            Configured.Maps.ForEach(map =>
            {
                It.IsEmpty(map.BulkLoad)
                    .AsGuard<ArgumentException>("bulk load schema not set on schema map");
                It.IsEmpty(map.BulkExport)
                    .AsGuard<ArgumentException>("bulk export template not set on schema map");
                It.IsInRange(map.Collection, TypeOfCollection.NotSet)
                    .AsGuard<ArgumentException>("collection type not set on schema map");
                It.IsEmpty(map.Message)
                    .AsGuard<ArgumentException>("message schema not set on schema map");
                It.IsEmpty(map.Namespace)
                    .AsGuard<ArgumentException>("namespace not set on schema map");
                It.IsInRange(map.Year, BatchOperatingYear.NotSet)
                    .AsGuard<ArgumentException>("batch operating year not set on schema map");
            });
        }

        /// <summary>
        /// Gets the schema.
        /// </summary>
        /// <param name="forThisNameSpace">For this name space.</param>
        /// <returns>a schema map</returns>
        public ISchemaMap GetSchema(string forThisNameSpace)
        {
            return Configured.Maps.FirstOrDefault(x => It.IsTheSame(x.Namespace, forThisNameSpace));
        }

        /// <summary>
        /// Gets the schema.
        /// </summary>
        /// <param name="forThisYear">For this year.</param>
        /// <returns>a schema map</returns>
        public ISchemaMap GetSchema(BatchOperatingYear forThisYear)
        {
            return Configured.Maps.FirstOrDefault(x => x.Year == forThisYear);
        }

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>the path to the configuration file</returns>
        public override string GetLoadPath()
        {
            return Path.Combine(Location.OfAssets, "schemamap.cfg");
        }
    }
}
