using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Schema;
using Tiny.Framework.Utilities;

namespace XML2SQL
{
    public class SQLSchema
    {
        //private struct Key
        //{
        //    public string Name;
        //    public string Declaration;
        //}

        //public bool IncludeFileId;
        //public bool CreateRelations = false;
        //public bool Identity = true;
        //public string TableNamePrefix;
        //public SQLTable FileTable;
        public string NameSpace { get; private set; }
        public ICollection<SQLTable> Tables { get; private set; }
        public XmlDocument TableHierarchy { get; private set; }
        public XmlDocument Relationships { get; private set; }

        public SQLSchema(string xmlSchemaPath)
        {
            //Load the schema
            var schema = LoadSchema(xmlSchemaPath);

            //Get the namespace
            NameSpace = schema.TargetNamespace;
            Tables = Collection.Empty<SQLTable>();
            TableHierarchy = new XmlDocument();

            //Loop through the top-level elements - only be one of these too
            var elements = schema.Elements.Values
                .OfType<XmlSchemaElement>()
                .AsSafeReadOnlyList();

            var failedCount = !It.HasCountOf(elements, 1);
            failedCount.AsGuard<ArgumentException>("too many root elements");

            elements.ForEach(x => TraverseParticle(x, schema, TableHierarchy, null));
        }

        public void SetRelationships(XmlDocument newRelationships)
        {
            Relationships = newRelationships;
            Tables.ForEach(table =>
            {
                table.DefineKeys(Relationships, GetKeys);
            });
        }

        public IReadOnlyCollection<SQLColumn> GetKeys(XmlNode node)
        {
            var keys = Collection.Empty<SQLColumn>();

            var keyNode = node.SelectSingleNode("./__keys__");
            if (It.Has(keyNode))
            {
                foreach (XmlNode key in keyNode.ChildNodes)
                {
                    keys.Add(Tables.Get(node.Name).Columns.Get(key.Name));
                }
            }

            if (It.Has(node.ParentNode))
            {
                var subKeys = GetKeys(node.ParentNode);
                subKeys.ForEach(keys.Add);
            }

            return keys.AsSafeReadOnlyList();
        }

        private IEnumerable<SQLTable> _bottomUpList;
        public IEnumerable<SQLTable> BottomUpTableList
        {
            get
            {
                return _bottomUpList
                    ?? (_bottomUpList = BuildBottomUpTableList(TableHierarchy.DocumentElement));
            }
        }

        public object ArgumentExcpetion { get; }

        public XmlSchema LoadSchema(string filePath)
        {
            var schemaSet = new XmlSchemaSet();
            schemaSet.Add(null, filePath);
            return schemaSet.Schemas().OfType<XmlSchema>().First();
        }

        private void TraverseParticle(XmlSchemaParticle particle, XmlSchema schema, XmlNode tableHierarchyParent, SQLTable parentTable)
        {
            //Cast the particle to an element
            var element = particle as XmlSchemaElement;
            var groupBase = particle as XmlSchemaGroupBase;

            //If the particle is an element
            if (It.Has(element))
            {
                if (It.Has(element.SchemaType))
                {
                    //If the element has a schema type

                    //Get the schema type
                    var schemaType = element.SchemaType;
                    if (schemaType is XmlSchemaSimpleType)
                    {
                        parentTable.Columns.Add(new SQLColumn(element.Name, (XmlSchemaSimpleType)schemaType, schema.SchemaTypes, element.MinOccurs > 0, false, parentTable, NameSpace));
                    }

                    //If the type is complex, then we'll need a table and we'll need to traverse the particles inside it
                    else if (schemaType is XmlSchemaComplexType)
                    {
                        var table = new SQLTable(element.Name, parentTable);
                        Tables.Add(table);
                        var complexType = schemaType as XmlSchemaComplexType;
                        var tableElement = TableHierarchy.CreateElement(table.Name);
                        tableHierarchyParent.AppendChild(tableElement);

                        if (complexType.Particle != null)
                        {
                            TraverseParticle(complexType.Particle, schema, tableElement, table);
                        }
                        else if (complexType.ContentModel != null)
                        {
                            if (complexType.ContentModel.Content is XmlSchemaComplexContentExtension)
                            {
                                var complexContentExtension = complexType.ContentModel.Content as XmlSchemaComplexContentExtension;
                                if (complexContentExtension.BaseTypeName.Namespace == NameSpace)
                                {
                                    //Get the schema type for the schema type name
                                    var contentSchemaType = (XmlSchemaType)schema.SchemaTypes[complexContentExtension.BaseTypeName];
                                    var contentComplexType = (XmlSchemaComplexType)contentSchemaType;
                                    //Check for and process attributes
                                    foreach (var schemaAttribute in contentComplexType.Attributes.OfType<XmlSchemaAttribute>())
                                    {
                                        if (schemaAttribute.SchemaTypeName.Namespace == NameSpace)
                                        {
                                            table.Columns.Add(new SQLColumn(schemaAttribute.Name, schemaAttribute.SchemaType, schema.SchemaTypes, (schemaAttribute.Use == XmlSchemaUse.Required), true, table, NameSpace));
                                        }
                                        else
                                        {
                                            table.Columns.Add(new SQLColumn(schemaAttribute.Name, new SQLDataType(schemaAttribute.SchemaTypeName.Name), (schemaAttribute.Use == XmlSchemaUse.Required), true, table, NameSpace));
                                        }
                                    }

                                    TraverseParticle(contentComplexType.Particle, schema, tableElement, table);
                                }
                            }
                        }
                    }
                    else
                    {
                        parentTable.Columns.Add(new SQLColumn(element.Name, new SQLDataType("unknown(1)"), element.MinOccurs > 0, false, parentTable, NameSpace));
                    }
                }
                else
                {
                    // Element has no schemaType

                    //If the element has a schema type name in the IA namespace
                    if (It.IsTheSame(element.SchemaTypeName.Namespace, NameSpace))
                    {
                        //Get the schema type for the schema type name
                        var schemaType = schema.SchemaTypes[element.SchemaTypeName] as XmlSchemaType;
                        //If the type is complex, then we'll need a table and we'll need to traverse the particles inside it
                        if (schemaType is XmlSchemaComplexType)
                        {
                            var table = new SQLTable(element.Name, parentTable);
                            Tables.Add(table);
                            var complexType = (XmlSchemaComplexType)schemaType;
                            var tableElement = TableHierarchy.CreateElement(table.Name);
                            tableHierarchyParent.AppendChild(tableElement);

                            //Check for and process attributes
                            foreach (XmlSchemaAttribute schemaAttribute in complexType.Attributes)
                            {
                                if (schemaAttribute.SchemaTypeName.Namespace == NameSpace)
                                {
                                    table.Columns.Add(new SQLColumn(schemaAttribute.Name, schemaAttribute.SchemaType, schema.SchemaTypes, (schemaAttribute.Use == XmlSchemaUse.Required), true, table, NameSpace));
                                }
                                else
                                {
                                    table.Columns.Add(new SQLColumn(schemaAttribute.Name, new SQLDataType(schemaAttribute.SchemaTypeName.Name), (schemaAttribute.Use == XmlSchemaUse.Required), true, table, NameSpace));
                                }
                            }

                            TraverseParticle(complexType.Particle, schema, tableElement, table);
                        }
                        else if (schemaType is XmlSchemaSimpleType)
                        {
                            parentTable.Columns.Add(new SQLColumn(element.Name, (XmlSchemaSimpleType)schemaType, schema.SchemaTypes, element.MinOccurs > 0, false, parentTable, NameSpace));
                        }
                        else
                        {
                            parentTable.Columns.Add(new SQLColumn(element.Name, new SQLDataType("unknown(2)"), element.MinOccurs > 0, false, parentTable, NameSpace));
                        }
                    }
                    else
                    {
                        //A really simple type!
                        parentTable.Columns.Add(new SQLColumn(element.Name, new SQLDataType(element.SchemaTypeName.Name), element.MinOccurs > 0, false, parentTable, NameSpace));
                    }
                }
            }

            if (It.Has(groupBase))
            {
                foreach (XmlSchemaParticle subParticle in groupBase.Items)
                {
                    TraverseParticle(subParticle, schema, tableHierarchyParent, parentTable);
                }
            }
        }

        public XmlDocument GenerateBulkLoadSchemaWithIdentity()
        {
            XmlDocument bulkLoadSchema = new XmlDocument();
            bulkLoadSchema.AppendChild(bulkLoadSchema.CreateElement("xsd", "schema", "http://www.w3.org/2001/XMLSchema"));
            bulkLoadSchema.DocumentElement.SetAttribute("xmlns:sql", "urn:schemas-microsoft-com:mapping-schema");
            bulkLoadSchema.DocumentElement.SetAttribute("attributeFormDefault", "unqualified");
            bulkLoadSchema.DocumentElement.SetAttribute("elementFormDefault", "qualified");
            bulkLoadSchema.DocumentElement.SetAttribute("targetNamespace", NameSpace);

            XmlElement annotation = bulkLoadSchema.CreateElement("xsd", "annotation", "http://www.w3.org/2001/XMLSchema");
            XmlElement appinfo = bulkLoadSchema.CreateElement("xsd", "appinfo", "http://www.w3.org/2001/XMLSchema");
            annotation.AppendChild(appinfo);
            bulkLoadSchema.DocumentElement.AppendChild(annotation);

            Dictionary<string, string> tableRelationships = new Dictionary<string, string>();
            foreach (SQLTable table in Tables)
            {
                if (table.Parent != null && table.Parent.Columns.Count > 0)
                {
                    XmlElement sqlRelationship = bulkLoadSchema.CreateElement("sql", "relationship", "urn:schemas-microsoft-com:mapping-schema");
                    sqlRelationship.SetAttribute("name", table.Parent.Name + "_" + table.Name);
                    sqlRelationship.SetAttribute("parent", table.Parent.Name);
                    sqlRelationship.SetAttribute("parent-key", "PK_" + table.Parent.Name);
                    sqlRelationship.SetAttribute("child", table.Name);
                    sqlRelationship.SetAttribute("child-key", "FK_" + table.Parent.Name);
                    appinfo.AppendChild(sqlRelationship);
                    tableRelationships.Add(table.Name, table.Parent.Name + "_" + table.Name);
                }
            }

            AddTablesToBulkLoadSchemaWithIdentity(bulkLoadSchema.DocumentElement, TableHierarchy, tableRelationships);

            return bulkLoadSchema;
        }

        //public XmlDocument GenerateBulkLoadSchema(XmlNode CurrentSchemaNode = null, XmlNode CurrentTableNode = null)
        //{
        //    XmlDocument bulkLoadSchema = new XmlDocument();
        //    bulkLoadSchema.AppendChild(bulkLoadSchema.CreateElement("xsd", "schema", "http://www.w3.org/2001/XMLSchema"));
        //    bulkLoadSchema.DocumentElement.SetAttribute("xmlns:sql", "urn:schemas-microsoft-com:mapping-schema");
        //    bulkLoadSchema.DocumentElement.SetAttribute("attributeFormDefault", "unqualified");
        //    bulkLoadSchema.DocumentElement.SetAttribute("elementFormDefault", "qualified");
        //    bulkLoadSchema.DocumentElement.SetAttribute("targetNamespace", NameSpace);


        //    Dictionary<string, string> tableRelationships = new Dictionary<string, string>();
        //    if (Relationships != null)
        //    {
        //        XmlElement annotation = bulkLoadSchema.CreateElement("xsd", "annotation", "http://www.w3.org/2001/XMLSchema");
        //        XmlElement appinfo = bulkLoadSchema.CreateElement("xsd", "appinfo", "http://www.w3.org/2001/XMLSchema");
        //        annotation.AppendChild(appinfo);
        //        bulkLoadSchema.DocumentElement.AppendChild(annotation);

        //        XmlNodeList keyNodes = Relationships.SelectNodes("//__keys__");
        //        foreach (XmlNode keyNode in keyNodes)
        //        {
        //            foreach (XmlNode childNode in keyNode.ParentNode.ChildNodes)
        //            {
        //                if (childNode.Name != "__keys__")
        //                {
        //                    var thisTable = Tables.Get(childNode.Name);
        //                    string keys = thisTable.GetInheritedKeyString();
        //                    XmlElement sqlRelationship = bulkLoadSchema.CreateElement("sql", "relationship", "urn:schemas-microsoft-com:mapping-schema");
        //                    sqlRelationship.SetAttribute("name", keyNode.ParentNode.Name + "_" + childNode.Name);
        //                    sqlRelationship.SetAttribute("parent", keyNode.ParentNode.Name);
        //                    sqlRelationship.SetAttribute("parent-key", keys);
        //                    sqlRelationship.SetAttribute("child", childNode.Name);
        //                    sqlRelationship.SetAttribute("child-key", keys);
        //                    appinfo.AppendChild(sqlRelationship);
        //                    tableRelationships.Add(childNode.Name, keyNode.ParentNode.Name + "_" + childNode.Name);
        //                }
        //            }
        //        }
        //    }

        //    AddTablesToBulkLoadSchema(bulkLoadSchema.DocumentElement, TableHierarchy, tableRelationships);

        //    return bulkLoadSchema;
        //}

        public ICollection<string> IndexCreationSQL()
        {
            var sql = Collection.Empty<string>();

            Tables.ForEach(table =>
            {
                var tableName = table.Name;
                if (table.Keys.Any())
                {
                    var keys = table.Keys.AsString();

                    var statement = table.HasPrimaryKey()
                        ? $"alter table [{tableName}] add constraint [PK_{tableName}] primary key clustered ({keys})"
                        : $"create index [IX_{tableName}] on [{tableName}] ({keys})";

                    sql.Add(statement);
                }
            });

            return sql;
        }
        public ICollection<string> AddTableKeyColumnsSQL()
        {
            var sql = Collection.Empty<string>();

            Tables.ForEach(table =>
            {
                var tableName = table.Name;
                var foreignKeys = table.Keys.Where(x => It.IsDifferent(x.Table.Name, table.Name));
                if (foreignKeys.Any())
                {
                    var keys = foreignKeys.AsString();

                    var statement = table.HasPrimaryKey()
                        ? $"alter table [{tableName}] add constraint [PK_{tableName}] primary key clustered ({keys})"
                        : $"create index [IX_{tableName}] on [{tableName}] ({keys})";

                    sql.Add(statement);
                }
            });

            return sql;
        }

        public ICollection<string> NotNullKeysSQL()
        {
            var sql = Collection.Empty<string>();

            Tables.ForEach(table =>
            {
                table.Keys.ForEach(column =>
                {
                    var tableName = table.Name;
                    var statement = $"alter table [{tableName}] alter column [{column.Name}] {column.SQLDeclaration} not null";
                    sql.Add(statement);
                });
            });

            return sql;
        }

        public void CreateIndices()
        {
            NotNullKeysSQL().ForEach(SQLDatabase.Execute);
            IndexCreationSQL().ForEach(SQLDatabase.Execute);
        }

        private void AddTablesToBulkLoadSchema(XmlNode currentSchemaNode, XmlNode currentTableNode, Dictionary<string, string> TableRelationships)
        {
            foreach (XmlElement tableElement in currentTableNode.ChildNodes)
            {
                XmlElement schemaElement = currentSchemaNode.OwnerDocument.CreateElement("xsd", "element", "http://www.w3.org/2001/XMLSchema");
                schemaElement.SetAttribute("name", tableElement.Name);
                if (!Tables.Get(tableElement.Name).Columns.Any())
                {
                    var isConstant = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "is-constant", "urn:schemas-microsoft-com:mapping-schema");
                    isConstant.Value = "1";
                    schemaElement.Attributes.Append(isConstant);
                }
                else
                {
                    var sqlRelation = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "relation", "urn:schemas-microsoft-com:mapping-schema");
                    sqlRelation.Value = tableElement.Name;
                    schemaElement.Attributes.Append(sqlRelation);

                    if (TableRelationships.ContainsKey(tableElement.Name))
                    {
                        var sqlRelationship = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "relationship", "urn:schemas-microsoft-com:mapping-schema");
                        sqlRelationship.Value = TableRelationships[tableElement.Name];
                        schemaElement.Attributes.Append(sqlRelationship);
                    }

                }

                currentSchemaNode.AppendChild(schemaElement);

                var complexType = currentSchemaNode.OwnerDocument.CreateElement("xsd", "complexType", "http://www.w3.org/2001/XMLSchema");
                schemaElement.AppendChild(complexType);
                var sequence = currentSchemaNode.OwnerDocument.CreateElement("xsd", "sequence", "http://www.w3.org/2001/XMLSchema");
                complexType.AppendChild(sequence);

                var foreignKeyColumns = Tables.Get(tableElement.Name).Keys.Where(x => It.IsDifferent(x.Table.Name, tableElement.Name));
                foreignKeyColumns.ForEach(column => sequence.AppendChild(ConvertColumnToElement(column, currentSchemaNode)));

                var tableColumns = Tables.Get(tableElement.Name).Columns;
                tableColumns.ForEach(column => sequence.AppendChild(ConvertColumnToElement(column, currentSchemaNode)));

                AddTablesToBulkLoadSchema(sequence, tableElement, TableRelationships);
            }
        }

        public XmlElement ConvertColumnToElement(SQLColumn column, XmlNode currentSchemaNode)
        {
            var columnElement = currentSchemaNode.OwnerDocument.CreateElement("xsd", "element", "http://www.w3.org/2001/XMLSchema");
            columnElement.SetAttribute("name", column.Name);
            columnElement.SetAttribute("type", "xsd:" + column.DataType.Name);
            var sqlTypeAttribute = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "datatype", "urn:schemas-microsoft-com:mapping-schema");
            sqlTypeAttribute.Value = column.SQLDeclaration;
            columnElement.Attributes.Append(sqlTypeAttribute);
            if (!column.Required)
            {
                columnElement.SetAttribute("minOccurs", "0");
            }

            return columnElement;
        }

        private void AddTablesToBulkLoadSchemaWithIdentity(XmlNode currentSchemaNode, XmlNode currentTableNode, Dictionary<string, string> tableRelationships)
        {
            foreach (XmlElement tableElement in currentTableNode.ChildNodes)
            {
                var schemaElement = currentSchemaNode.OwnerDocument.CreateElement("xsd", "element", "http://www.w3.org/2001/XMLSchema");
                schemaElement.SetAttribute("name", tableElement.Name);
                if (!Tables.Get(tableElement.Name).Columns.Any())
                {
                    var isConstant = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "is-constant", "urn:schemas-microsoft-com:mapping-schema");
                    isConstant.Value = "1";
                    schemaElement.Attributes.Append(isConstant);
                }
                else
                {
                    var sqlRelation = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "relation", "urn:schemas-microsoft-com:mapping-schema");
                    sqlRelation.Value = tableElement.Name;
                    schemaElement.Attributes.Append(sqlRelation);

                    if (tableRelationships.ContainsKey(tableElement.Name))
                    {
                        var sqlRelationship = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "relationship", "urn:schemas-microsoft-com:mapping-schema");
                        sqlRelationship.Value = tableRelationships[tableElement.Name];
                        schemaElement.Attributes.Append(sqlRelationship);
                    }
                }

                currentSchemaNode.AppendChild(schemaElement);

                var complexType = currentSchemaNode.OwnerDocument.CreateElement("xsd", "complexType", "http://www.w3.org/2001/XMLSchema");
                schemaElement.AppendChild(complexType);
                var sequence = currentSchemaNode.OwnerDocument.CreateElement("xsd", "sequence", "http://www.w3.org/2001/XMLSchema");
                complexType.AppendChild(sequence);

                var thisTable = Tables.Get(tableElement.Name);

                if (It.HasValues(thisTable.Columns))
                {
                    var primaryKeyElement = currentSchemaNode.OwnerDocument.CreateElement("xsd", "element", "http://www.w3.org/2001/XMLSchema");
                    primaryKeyElement.SetAttribute("name", "PK_" + thisTable.Name);
                    primaryKeyElement.SetAttribute("type", "xsd:int");
                    var sqlTypeAttribute = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "datatype", "urn:schemas-microsoft-com:mapping-schema");
                    sqlTypeAttribute.Value = "int";
                    primaryKeyElement.Attributes.Append(sqlTypeAttribute);
                    sequence.AppendChild(primaryKeyElement);

                    if (thisTable.Parent != null && thisTable.Parent.Columns.Any())
                    {
                        var parentKeyElement = currentSchemaNode.OwnerDocument.CreateElement("xsd", "element", "http://www.w3.org/2001/XMLSchema");
                        parentKeyElement.SetAttribute("name", "FK_" + thisTable.Parent.Name);
                        parentKeyElement.SetAttribute("type", "xsd:int");
                        sqlTypeAttribute = currentSchemaNode.OwnerDocument.CreateAttribute("sql", "datatype", "urn:schemas-microsoft-com:mapping-schema");
                        sqlTypeAttribute.Value = "int";
                        parentKeyElement.Attributes.Append(sqlTypeAttribute);
                        sequence.AppendChild(parentKeyElement);
                    }
                }

                thisTable.Columns.ForEach(column => sequence.AppendChild(ConvertColumnToElement(column, currentSchemaNode)));

                AddTablesToBulkLoadSchemaWithIdentity(sequence, tableElement, tableRelationships);
            }
        }

        public void CreateTables(string tableNamePrefix = "")
        {
            //Store the table name prefix
            //TableNamePrefix = tableNamePrefix;

            Tables.ForEach(table =>
            {
                if (table.Columns.Any())
                {
                    table.Create();
                }
            });
        }

        //public void CreateNamespaceTables()
        //{
        //    //Create tables to hold the namespace info and xml declarations
        //    string tableName = TableNamePrefix + "__XMLNamespaceStuff";
        //    SQLDatabase.DropTable(tableName);
        //    var sql = $"create table [{tableName}] ({GetPKFilePart()} [name] varchar(255), [value] varchar(255))";
        //    SQLDatabase.Execute(sql);

        //    tableName = TableNamePrefix + "__XMLDeclaration";
        //    SQLDatabase.DropTable(tableName);
        //    sql = $"create table [{tableName}] ({GetPKFilePart()} version varchar(255), encoding varchar(255), standalone varchar(255))";
        //    SQLDatabase.Execute(sql);

        //    tableName = TableNamePrefix + "__XMLSchemaInfo";
        //    SQLDatabase.DropTable(tableName);
        //    sql = $"create table [{tableName}] ({GetPKFilePart()} namespace varchar(255))";
        //    SQLDatabase.Execute(sql);
        //    sql = $"insert into [{tableName}] values('{NameSpace}')";
        //    SQLDatabase.Execute(sql);
        //}

        /*
         * this is all part of bulk loading, which we don't do here
        public void LoadXMLintoSQL(string inputFile)
        {
            //Load the XML into a document
            XmlDocument data = new XmlDocument();
            data.Load(inputFile);

            //Create a file record if we're doing that sort of thing
            //if (IncludeFileId)
            //{
            //    List<string> values = new List<string>();
            //    values.Add(InputFile);
            //    FileTable.Insert(values);
            //}

            //Store the declaration from the document
            StoreDeclaration(data);

            //Get the namespace from the document element
            NameSpace = data.DocumentElement.NamespaceURI;

            //Store the namespace attributes for use when the XML is written out again
            StoreNamespaceStuff(data);

            //Process XML
            processXMLData(data.DocumentElement);
        }

        //public void LoadXMLintoSQL(string[] InputFiles)
        //{
        //    //Loop though the files loading each into the database
        //    foreach (string inputFile in InputFiles)
        //        LoadXMLintoSQL(inputFile);
        //}

        private void StoreDeclaration(XmlDocument Document)
        {
            if (Document.FirstChild is XmlDeclaration)
            {
                var declaration = (XmlDeclaration)Document.FirstChild;
                var sql = $"insert into [__XMLDeclaration] values ('{declaration.Version}','{declaration.Encoding}','{declaration.Standalone}')";
                SQLDatabase.Execute(sql);
            }
        }

        private void StoreNamespaceStuff(XmlDocument Document)
        {
            var table = Tables.Get(Document.DocumentElement.Name);

            foreach (XmlAttribute attribute in Document.DocumentElement.Attributes)
            {
                if (It.IsNull(table.Columns.Get(attribute.Name)))
                {
                    string sql = $"insert into [__XMLNamespaceStuff] values('{attribute.Name}','{attribute.Value}')";
                    SQLDatabase.Execute(sql);
                }
            }
        }

        private XmlDeclaration LoadDeclaration(XmlDocument Document)
        {
            XmlDeclaration dec = null;
            var reader = SQLDatabase.ExecuteReader($"select * from [__XMLDeclaration]");

            if (reader.Read())
            {
                var version = reader.GetString(reader.GetOrdinal("version"));
                var encoding = reader.GetString(reader.GetOrdinal("encoding"));
                var standalone = reader.GetString(reader.GetOrdinal("standalone"));
                dec = Document.CreateXmlDeclaration(version, encoding, standalone);
            }

            reader.Close();
            return dec;
        }

        private string GetXMLDeclaration()
        {
            using (var reader = SQLDatabase.ExecuteReader("select * from [__XMLDeclaration]"))
            {
                string result = "";
                if (reader.Read())
                {
                    var version = reader.GetString(reader.GetOrdinal("version"));
                    var encoding = reader.GetString(reader.GetOrdinal("encoding"));
                    var standalone = reader.GetString(reader.GetOrdinal("standalone"));

                    if (It.Has(version) || It.Has(encoding) || It.Has(standalone))
                    {
                        result = "<?xml";
                        if (It.Has(version))
                            result += $" version=\"{version}\"";
                        if (It.Has(encoding))
                            result += $" encoding=\"{encoding}\"";
                        if (It.Has(standalone))
                            result += $" standalone=\"{standalone}\"";
                        result += "?>";
                    }
                }

                return result;
            }
        }

        private void processXMLData(XmlNode Data)
        {
            //Insert the data
            Tables.Get(Data.Name).Insert(Data);

            //Loop through all child nodes
            Data.ChildNodes.OfType<XmlNode>().ForEach(child =>
            {
                //If the child has children of its own process it as it'll be a new record in a table
                if (child.HasChildNodes && child.FirstChild.NodeType != XmlNodeType.Text)
                {
                    processXMLData(child);
                }
            });
        }

        public void SaveSQLAsXML(string OutputFile)
        {
            //Create an empty XMLDocument for the output
            var xmlOutput = new XmlDocument();

            //Declare the encoding
            XmlDeclaration dec;
            if ((dec = LoadDeclaration(xmlOutput)) != null)
                xmlOutput.AppendChild(dec);

            //Traverse table hierarchy adding data to the XML
            TraverseTableHierarchy(TableHierarchy.DocumentElement, xmlOutput, xmlOutput);

            //Add any other namespace stuff to the document element
            AddNamespaceStuff(xmlOutput.DocumentElement);

            //Save the XML
            xmlOutput.Save(OutputFile);
        }

        private void AddNamespaceStuff(XmlElement Element)
        {
            var tableName = "__XMLNamespaceStuff";
            string sql = $"select [name],[value] from [{tableName}] where name like 'xmlns*' union select [name],[value] from [{tableName}] where name not like 'xmlns*'";
            using (var reader = SQLDatabase.ExecuteReader(sql))
            {
                while (reader.Read())
                {
                    string name = reader.GetString(0);
                    string value = reader.GetString(1);

                    if (name == "xmlns" && NameSpace.Length > 0 && NameSpace != value)
                    {
                        value = NameSpace;
                    }

                    if (!name.StartsWith("xmlns") && name.Contains(":"))
                    {
                        string[] nameParts = name.Split(':');
                        var nameSpaceUri = SQLDatabase.ExecuteScalar<string>($"select [value] from [{tableName}] where name='xmlns:{nameParts[0]}'");
                        Element.SetAttribute(nameParts[1], nameSpaceUri, value);
                    }
                    else
                    {
                        Element.SetAttribute(name, value);
                    }
                }
            }
        }

                    public void SaveSQLAsXMLQuickly(string OutputFile)
        {
            //Create a writer
            using (var writer = File.CreateText(OutputFile))
            {
                //Declare the encoding
                string declaration = GetXMLDeclaration();
                if (declaration.Length > 0)
                {
                    writer.WriteLine(declaration);
                }

                //Traverse table hierarchy adding data to the XML
                TraverseTableHierarchy(TableHierarchy.DocumentElement, writer);

                //Close the writer
                writer.Flush();
            }
        }

        private string GetNamespaceStuff()
        {
            string namespaceStuff = "";
            string sql = "select [name],[value] from [__XMLNamespaceStuff] where name like 'xmlns*' union select [name],[value] from [__XMLNamespaceStuff] where name not like 'xmlns*'";
            var reader = SQLDatabase.ExecuteReader(sql);

            while (reader.Read())
            {
                string name = reader.GetString(0);
                string value = reader.GetString(1);
                if (name == "xmlns" && NameSpace.Length > 0 && NameSpace != value)
                    value = NameSpace;

                namespaceStuff += " " + name + "=\"" + value + "\"";
            }
            reader.Close();
            return namespaceStuff;
        }

                    private void TraverseTableHierarchy(XmlNode TableHierarchyPoint, TextWriter Writer, string Indent = "", double? ParentKey = null)
        {
            //Get the table named in the xml node
            string tableName = TableHierarchyPoint.Name;
            var table = Tables.Get(tableName);

            //Get the namespace stuff
            string namespaceStuff = null;
            if (ParentKey == null)
                namespaceStuff = GetNamespaceStuff();

            //Read each record in the table for parent record's key (if there is a parent)
            var reader = table.Select(ParentKey);
            while (reader.Read())
            {
                //Add data to XML
                if (ParentKey == null)
                    Writer.WriteLine(Indent + "<" + tableName + namespaceStuff + ">");
                else
                    Writer.WriteLine(Indent + "<" + tableName + ">");
                foreach (var column in table.Columns)
                {
                    int ordinal = reader.GetOrdinal(column.Name);
                    if (!reader.IsDBNull(ordinal))
                    {
                        string value;
                        switch (column.DataType.NativeSQLDataType.ToLower())
                        {
                            case "varchar":
                                value = reader.GetString(ordinal);
                                break;
                            case "bigint":
                                value = reader.GetInt64(ordinal).ToString();
                                break;
                            case "long":
                            case "int":
                                value = reader.GetInt32(ordinal).ToString();
                                break;
                            case "double":
                            case "float":
                                value = reader.GetDouble(ordinal).ToString();
                                break;
                            case "datetime":
                                value = reader.GetDateTime(ordinal).ToString("yyyy-MM-ddTHH:mm:ss");
                                if (column.DataType.Name == "date")
                                    value = value.Substring(0, 10);
                                break;
                            default:
                                value = "Unhandled Data type " + column.DataType.NativeSQLDataType;
                                break;
                        }

                        if (column.IsAttribute)
                        {
                            //tableElement.SetAttribute(column.Name, value);
                        }
                        else
                        {
                            Writer.WriteLine(Indent + "\t<" + column.Name + ">" + EscapeForXML(value) + "</" + column.Name + ">");
                        }
                    }
                }

                //Get the primary key to pass to the processing of the child nodes
                int parentKey = reader.GetInt32(reader.GetOrdinal("PK_" + tableName));

                //Process any child tables                
                foreach (var childTableNode in TableHierarchyPoint.ChildNodes.OfType<XmlNode>())
                    TraverseTableHierarchy(childTableNode, Writer, Indent + "\t", parentKey);
                Writer.WriteLine(Indent + "</" + tableName + ">");

            }
            if (!reader.IsClosed)
                reader.Close();
        }

        private string EscapeForXML(string Value)
        {
            Value = Value.Replace("&", "&amp;");
            Value = Value.Replace("<", "&lt;");
            Value = Value.Replace(">", "&gt;");
            Value = Value.Replace("\"", "&quot;");
            Value = Value.Replace("'", "&apos;");

            return Value;
        }

                    private void TraverseTableHierarchy(XmlNode TableHierarchyPoint, XmlDocument XmlOutput, XmlNode OutputNode, double? ParentKey = null)
        {
            //Get the table named in the xml node
            string tableName = TableHierarchyPoint.Name;
            var table = Tables.Get(tableName);

            //Read each record in the table for parent record's key (if there is a parent)
            var reader = table.Select(ParentKey);
            while (reader.Read())
            {
                //Add data to XML
                XmlElement tableElement = XmlOutput.CreateElement(tableName, NameSpace);
                foreach (SQLColumn column in table.Columns)
                {
                    int ordinal = reader.GetOrdinal(column.Name);
                    if (!reader.IsDBNull(ordinal))
                    {
                        string value;
                        switch (column.DataType.NativeSQLDataType.ToLower())
                        {
                            case "text":
                                value = reader.GetString(ordinal);
                                break;
                            case "long":
                                value = reader.GetInt32(ordinal).ToString();
                                break;
                            case "float":
                            case "double":
                                value = reader.GetDouble(ordinal).ToString();
                                break;
                            case "datetime":
                                value = reader.GetDateTime(ordinal).ToString("yyyy-MM-ddTHH:mm:ss");
                                if (column.DataType.Name == "date")
                                    value = value.Substring(0, 10);
                                break;
                            default:
                                value = "Unhandled Data type " + column.DataType.NativeSQLDataType;
                                break;
                        }

                        if (column.IsAttribute)
                        {
                            tableElement.SetAttribute(column.Name, value);
                        }
                        else
                        {
                            XmlElement fieldElement = OutputNode.OwnerDocument.CreateElement(column.Name, NameSpace);
                            fieldElement.InnerText = value;
                            tableElement.AppendChild(fieldElement);
                        }
                    }
                }

                OutputNode.AppendChild(tableElement);

                //Process any child tables
                foreach (XmlNode childTableNode in TableHierarchyPoint.ChildNodes)
                {
                    TraverseTableHierarchy(childTableNode, XmlOutput, tableElement, reader.GetDouble(reader.GetOrdinal("PK_" + tableName)));
                }
            }

            reader.Close();
        }

         */

        private IEnumerable<SQLTable> BuildBottomUpTableList(XmlNode TableNode)
        {
            var tables = new List<SQLTable>();

            //TableNode = TableHierarchy.DocumentElement;

            foreach (XmlNode childTableNode in TableNode.ChildNodes)
            {
                var subTables = BuildBottomUpTableList(childTableNode);
                if (subTables.Any())
                {
                    tables.AddRange(subTables);
                }
            }

            //Tables.Add(Tables.Get(TableNode.Name));

            return tables;
        }
    }
}
