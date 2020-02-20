using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Xml;
using Tiny.Framework.Utilities;

namespace XML2SQL
{
    public class SQLTable : ISQLNamedItem
    {
        public SQLTable Parent;
        public string Name { get; set; }
        public List<SQLColumn> Columns = new List<SQLColumn>();
        public IReadOnlyCollection<SQLColumn> Keys = Collection.EmptyAndReadOnly<SQLColumn>();
        public int LastPK = 0;
        //public SQLSchema Schema;

        public SQLTable() { }

        public SQLTable(string name, SQLTable parent)
        {
            Name = name;
            Parent = parent;
        }

        //public SQLTable(string name, SQLTable parent)//, SQLSchema schema)
        //{
        //    Name = name;
        //    Parent = parent;
        //    //Schema = schema;
        //}

        //public string GetCreateTableSQL()
        //{
        //    string tableName = Name;// Schema.TableNamePrefix + Name;
        //    string sql = $"create table [{tableName}] (";
        //    //if (Schema.IncludeFileId && Name != "__File")
        //    //    sql += "[PK_File] int,";
        //    sql += "[PK_" + Name + "] int,";
        //    if (It.Has(Parent))
        //        sql += "[FK_" + Parent.Name + "] int not null,";
        //    sql += string.Join(",", Columns.Select(x => x.GetCreateColumnSQL()));
        //    sql += $" constraint {tableName}_PK primary key ([PK_{Name}]))";

        //    return sql;
        //}

        //public string GetCreateTableWithIdentitySQL()
        //{
        //    string tableName = Name; // Schema.TableNamePrefix + Name;
        //    string sql = "create table [" + tableName + "] (";
        //    //if (Schema.IncludeFileId && Name != "__File")
        //    //    sql += "[PK_File] int,";
        //    sql += "[PK_" + Name + "] int identity,";
        //    if (It.Has(Parent))
        //    {
        //        sql += "[FK_" + Parent.Name + "] int not null,";
        //    }
        //    sql += string.Join(",", Columns.Select(x => x.GetCreateColumnSQL()));
        //    sql += $" constraint {tableName}_PK primary key ([PK_{Name}]))";

        //    return sql;
        //}

        public string GetParentForeignKeyPart(SQLTable parent)
        {
            return It.Has(Parent) && It.HasValues(Parent.Columns)
                ? $"[FK_{Parent.Name}] int not null,"
                : string.Empty;
        }

        public string GetCreateTableSQL()
        {
            var columns = string.Join(", ", Columns.Select(x => x.GetCreateColumnSQL()));
            //var foreignColumns = string.Join(",", Keys.Where(x => x.Table.Name != Name).Select(y => y.GetCreateColumnSQL()));
            //if(It.Has(foreignColumns) && !foreignColumns.EndsWith(","))
            //{
            //    foreignColumns = $"{foreignColumns},";
            //}

            //return $"create table [{Name}] ([PK_{Name}] int identity,{GetParentForeignKeyPart(Parent)}{foreignColumns}{columns} constraint {Name}_PK primary key ([PK_{Name}]))";
            return $"create table [{Name}] ([PK_{Name}] int identity,{GetParentForeignKeyPart(Parent)}{columns} constraint {Name}_PK primary key ([PK_{Name}]))";
        }

        //public string CreateMainIndexSQL()
        //{
        //    string tableName = Schema.TableNamePrefix + Name;
        //    string sql = "create index [IDX_" + tableName + "] on [" + tableName + "] (";
        //    if (Schema.IncludeFileId)
        //        sql += "[PK_File] asc,";
        //    if (Parent != null)
        //        sql += "[FK_" + Parent.Name + "] asc,";
        //    sql += "[PK_" + Name + "] asc)";

        //    return sql;
        //}

        public string GetParentIndexPart(SQLTable parent)
        {
            return It.Has(Parent) && It.HasValues(Parent.Columns)
                ? $"[FK_{Parent.Name}] asc,"
                : string.Empty;
        }

        public string GetCreateMainIndexSQL()
        {
            return $"create index [IDX_{Name}] on [{Name}] ({GetParentIndexPart(Parent)} [PK_{Name}] asc)";
        }

        public string GetCreateForeignKeyConstraintSQL()
        {
            if (It.IsNull(Parent))
            {
                return null;
            }

            return $"alter table [{Name}] add constraint [FK_{Name}] foreign key([FK_{Parent.Name}]) references [{Parent.Name}]([PK_{Parent.Name}])";
        }

        public string GetDropTableSQL()
        {
            return $"drop table[{Name}]";
        }

        public string GetColumnsString()
        {
            string columns = string.Join(", ", Columns.Select(x => $"[{x.Name}]"));
            return $"[PK_{Name}],{(It.Has(Parent) ? "$[FK_{Parent.Name}]," : string.Empty)}{columns}";
        }

        public void Create()
        {
            Drop();

            //if (createNoColumnTables)
            //{
            //    SQLDatabase.Execute(Schema.Identity ? GetCreateTableWithIdentitySQL() : GetCreateTableSQL());
            //    SQLDatabase.Execute(CreateMainIndexSQL());
            //}
            //else
            //{
            SQLDatabase.Execute(GetCreateTableSQL());
            SQLDatabase.Execute(GetCreateMainIndexSQL());
            //}

            //if (Schema.CreateRelations && It.HasValues(Parent?.Columns))
            //{
            //    SQLDatabase.Execute(GetCreateForeignKeyConstraintSQL());
            //}
        }

        public void Drop()
        {
            SafeActions.Try(() => SQLDatabase.Execute(GetDropTableSQL()));
        }

        public string InsertSQL(XmlNode Data, string nameSpace)
        {
            //Set up a stupid namespace thing or else select single node doesn't work
            var nsManager = new XmlNamespaceManager(Data.OwnerDocument.NameTable);
            nsManager.AddNamespace("ia", nameSpace);

            //Start building the string with the insert SQL
            string tableName = Name;// Schema.TableNamePrefix + Name;
            string sql = $"insert into [{tableName}] ({GetColumnsString()}) values(";

            //Add the primary key field value to the insert SQL and the node
            sql += $"{++LastPK},";
            var pk = Data.OwnerDocument.CreateElement($"PK_{Name}");
            pk.InnerText = $"{LastPK}";
            Data.AppendChild(pk);

            //Add the parent's PK if there is one
            if (It.Has(Parent))
            {
                var fkNode = Data.ParentNode.SelectSingleNode($"PK_{Parent.Name}");
                if (It.Has(fkNode))
                {
                    sql += $"{fkNode.InnerText},";
                    var fk = Data.OwnerDocument.CreateElement($"FK_{Parent.Name}");
                    fk.InnerText = fkNode.InnerText;
                    Data.AppendChild(fk);
                }
            }

            //Add data for each column
            foreach (SQLColumn column in Columns)
            {
                string value = null;

                if (column.IsAttribute && Data.Attributes[column.Name] != null)
                {
                    value = Data.Attributes[column.Name].Value;
                }
                else
                {
                    //Get the node for the column
                    XmlNode columnNode = Data.SelectSingleNode("ia:" + column.Name, nsManager);

                    //If we find the node, append the value to the sql with appropriate delimiters
                    if (columnNode != null && columnNode.InnerText.Length > 0)
                    {
                        value = columnNode.InnerText;
                    }
                }

                if (value != null)
                {
                    switch (column.DataType.Name.ToLower())
                    {
                        case "string":
                            sql += "'" + ((string)value).Replace("'", "''") + "',";
                            break;
                        case "date":
                        case "datetime":
                            if ((value.Contains("0000-")) || (value.Contains("0001-")))
                            {
                                // Added by PC as had issue loading into DateTime column. Must be aftyer 1754-01-01
                                value = value.ToString().Replace("0000-", "1800-").Replace("0001-", "1800-");
                            }
                            DateTime dateTime = XmlConvert.ToDateTime(value);
                            sql += "'" + dateTime.ToString("yyyy-MMM-dd HH:mm:ss") + "',";
                            break;
                        default:
                            sql += value + ",";
                            break;
                    }
                }
                else
                    sql += "null,";
            }

            //Drop the trailing comma and add a closing bracket to complete the sql statement
            sql = sql.Substring(0, sql.Length - 1) + ")";

            return sql;
        }

        public string InsertSQL(ICollection<string> values)
        {
            //Start building the string with the insert SQL
            string tableName = Name;// Schema.TableNamePrefix + Name;
            string sql = "insert into [" + tableName + "] values(";

            //If not loading the __File table itself and we're using file Ids then add the file Id 
            //if (Schema.IncludeFileId && Name != "__File")
            //    sql += (Schema.FileTable.LastPK).ToString() + ",";

            //Add the primary key field value to the insert SQL and the node
            sql += (++LastPK).ToString() + ",";

            //Add data for each column
            for (int i = 0; i < Columns.Count; i++)
            {
                // big assumption here that we get the right column
                var column = Columns.ElementAt(i);
                var value = values.ElementAt(i);

                if (It.Has(value))
                {
                    switch (column.DataType.Name.ToLower())
                    {
                        case "string":
                            sql += "'" + value.Replace("'", "''") + "',";
                            break;
                        case "date":
                        case "datetime":
                            DateTime dateTime = XmlConvert.ToDateTime(value);
                            sql += "#" + dateTime.ToString("yyyy-MM-dd HH:mm:ss") + "#,";
                            break;
                        default:
                            sql += value + ",";
                            break;
                    }
                }
                else
                {
                    sql += "null,";
                }
            }

            //Drop the trailing comma and add a closing bracket to complete the sql statement
            sql = sql.Substring(0, sql.Length - 1) + ")";

            return sql;
        }

        public void Insert(XmlNode data, string nameSpace)
        {
            SQLDatabase.Execute($"SET IDENTITY_INSERT [{Name}] ON");
            SQLDatabase.Execute(InsertSQL(data, nameSpace));
            SQLDatabase.Execute($"SET IDENTITY_INSERT [{Name}] OFF");
        }

        public void Insert(ICollection<string> values)
        {
            SQLDatabase.Execute(InsertSQL(values));
        }

        public string SelectSQL(double? parentKey = null)
        {
            string tableName = Name; // Schema.TableNamePrefix + Name;
            string sql = $"select * from [{tableName}]";
            if (It.Has(Parent) && It.Has(parentKey))
                sql += $" where [FK_{Parent.Name}]={parentKey}";
            sql += $" order by [PK_{Name}]";
            return sql;
        }

        public IDataReader Select(double? parentKey = null)
        {
            return SQLDatabase.ExecuteReader(SelectSQL(parentKey));
        }

        public void DefineKeys(XmlDocument KeyDefinitions, Func<XmlNode, IReadOnlyCollection<SQLColumn>> getKeysAction)
        {
            var tableNode = KeyDefinitions.SelectSingleNode($"//{Name}");
            if (tableNode != null)
            {
                Keys = getKeysAction(tableNode);
            }
        }

        public string GetInheritedKeyString()
        {
            return string.Join(" ", Keys.Where(x => x.Table != this).Select(y => y.Name));
        }

        public bool HasPrimaryKey()
        {
            return Keys.Any(x => x.Table == this);
        }
    }
}
