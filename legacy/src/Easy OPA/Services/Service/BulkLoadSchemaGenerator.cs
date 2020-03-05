using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.IO;
using System.Threading.Tasks;
using System.Xml;
using Tiny.Framework.Utilities;
using XML2SQL;

namespace EasyOPA.Service
{
    /// <summary>
    /// bulk load schema generator
    /// </summary>
    /// <seealso cref="IGenerateBulkLoadSchemas" />
    [Shared]
    [Export(typeof(IGenerateBulkLoadSchemas))]
    public sealed class BulkLoadSchemaGenerator :
        IGenerateBulkLoadSchemas
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the schema (provider).
        /// </summary>
        [Import]
        public IProvideSchemaConfigurations Schemas { get; set; }

        /// <summary>
        /// Gets or sets the (asset) location (provider).
        /// </summary>
        [Import]
        public IProvideAssetLocation Location { get; set; }

        /// <summary>
        /// Gets the relations.
        /// </summary>
        /// <param name="usingRelationsPath">using (the) relations path.</param>
        /// <param name="andNamespace">and (the) namespace.</param>
        /// <returns>the loaded relationships document</returns>
        public XmlDocument GetRelations(string usingRelationsPath, string andNamespace)
        {
            var relations = new XmlDocument();
            relations.Load(usingRelationsPath);
            var schemaRelations = relations.SelectSingleNode($"Schemas/Schema[@ns='{andNamespace}']");

            var relationsForSchema = new XmlDocument();
            var copiedNode = relationsForSchema.ImportNode(schemaRelations, true);
            relationsForSchema.AppendChild(copiedNode);

            return relationsForSchema;
        }

        /// <summary>
        /// Generates the schema.
        /// </summary>
        /// <param name="forMessageNamespace">for message namespace.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="andExecuteBulkload">and execute (a) bulk load</param>
        /// <returns>
        /// the schema map sued to generate the data source
        /// </returns>
        public async Task<ISchemaMap> Generate(string forMessageNamespace, IConnectionDetail inContext, Action<IConnectionDetail, string, bool> andExecuteBulkload)
        {
            It.IsEmpty(forMessageNamespace)
                .AsGuard<ArgumentNullException>(nameof(forMessageNamespace));
            It.IsNull(andExecuteBulkload)
                .AsGuard<ArgumentNullException>(nameof(andExecuteBulkload));

            return await Task.Run(() =>
            {
                var schemaMap = Schemas.GetSchema(forMessageNamespace);

                It.IsNull(schemaMap)
                    .AsGuard<ArgumentException, Localised>(Localised.FailedToObtainSchemaMap);

                var loadSchemaPath = Path.Combine(Location.OfAssets, schemaMap.BulkLoad);
                var messageSchemaPath = Path.Combine(Location.OfAssets, schemaMap.Message);
                var relationshipsPath = Path.Combine(Location.OfAssets, "relationships.xml");


                SQLDatabase.Open(inContext.SQLDetail);

                var sqlSchema = new SQLSchema(messageSchemaPath);
                var relations = GetRelations(relationshipsPath, sqlSchema.NameSpace);
                sqlSchema.SetRelationships(relations);

                var autoGenerateTables = false;
                //var newPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "newSchema.xml");
                //var buildSchema = sqlSchema.GenerateBulkLoadSchemaWithIdentity();
                //buildSchema.Save(newPath);

                if (!autoGenerateTables)
                {
                    sqlSchema.CreateTables();
                }

                andExecuteBulkload(inContext, loadSchemaPath, autoGenerateTables);

                SQLDatabase.Close();

                return schemaMap;
            });
        }
    }
}
