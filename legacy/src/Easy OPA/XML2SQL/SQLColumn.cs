using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using System.Xml.Schema;

namespace XML2SQL
{
    public class SQLColumn : ISQLNamedItem
    {
        public string Name { get; private set; }
        public SQLDataType DataType;
        public bool Required;
        public bool IsAttribute;
        public SQLTable Table;

        public string SQLDeclaration
        {
            get
            {
                string columnDeclaration = DataType.NativeSQLDataType;
                if (DataType.Name == "string" && DataType.Size > 0)
                {
                    columnDeclaration += $"({DataType.Size})";
                }

                return columnDeclaration;
            }
        }

        public string GetCreateColumnSQL()
        {
            return $"[{Name}] {SQLDeclaration} {(Required ? "NOT NULL" : string.Empty)}".Trim();
        }

        //public SQLColumn(SQLTable table)
        //{
        //    Table = table;
        //}

        public SQLColumn(string name, SQLDataType dataType, bool required, bool isAttribute, SQLTable table, string nameSpace)
        {
            Name = name;
            DataType = dataType;
            Required = required;
            IsAttribute = isAttribute;
            Table = table;
        }

        public SQLColumn(string name, XmlSchemaSimpleType schemaType, XmlSchemaObjectTable schemaTypes, bool required, bool isAttribute, SQLTable table, string nameSpace)
        {
            Name = name;
            Required = required;
            DataType = GetDataType(schemaType, schemaTypes, 0, nameSpace);
            IsAttribute = isAttribute;
            Table = table;
        }

        private static SQLDataType GetDataType(XmlSchemaSimpleType schemaType, XmlSchemaObjectTable schemaTypes, int size, string nameSpace)
        {
            var result = new SQLDataType();

            if (size != 0)
            {
                result.Size = size;
            }

            if (schemaType.Content is XmlSchemaSimpleTypeRestriction)
            {
                var restriction = (XmlSchemaSimpleTypeRestriction)schemaType.Content;
                foreach (XmlSchemaFacet facet in restriction.Facets)
                {
                    if (facet is XmlSchemaMaxLengthFacet)
                    {
                        var maxLength = (XmlSchemaMaxLengthFacet)facet;
                        result.Size = Int32.Parse(maxLength.Value);
                    }
                    else if (facet is XmlSchemaTotalDigitsFacet)
                    {
                        var totalDigits = (XmlSchemaTotalDigitsFacet)facet;
                        result.Size = Int32.Parse(totalDigits.Value);
                    }
                    else if (facet is XmlSchemaEnumerationFacet)
                    {
                        if (facet.Value.Length > result.Size)
                            result.Size = facet.Value.Length;
                    }
                    else if (facet is XmlSchemaLengthFacet)
                    {
                        var length = (XmlSchemaLengthFacet)facet;
                        result.Size = Int32.Parse(length.Value);
                    }
                    else if (facet is XmlSchemaPatternFacet && result.Size == 0)
                    {
                        var pattern = (XmlSchemaPatternFacet)facet;
                        var patternValue = pattern.Value;
                        if (patternValue.Contains("{") && patternValue.Contains("}"))
                        {
                            var candidate = patternValue;
                            var results = new List<int>();
                            var temp = GetPatternFacetFieldLengths(candidate);
                            while (temp.Any())
                            {
                                results = results.Concat(temp).ToList();
                                var start = candidate.IndexOf("}") + 1;
                                candidate = candidate.Substring(start);
                                temp = GetPatternFacetFieldLengths(candidate);
                            }

                            result.Size = results.Max();
                        }
                    }
                }

                if (restriction.BaseTypeName.Namespace == nameSpace)
                {
                    //Get the schema type for the schema type name
                    var _schemaType = (XmlSchemaType)schemaTypes[new XmlQualifiedName(restriction.BaseTypeName.Name, restriction.BaseTypeName.Namespace)];
                    if (_schemaType is XmlSchemaSimpleType)
                    {
                        return GetDataType((XmlSchemaSimpleType)_schemaType, schemaTypes, result.Size, nameSpace);
                    }
                    else
                    {
                        result.Name = "unknown(5)";
                    }
                }
                else
                {
                    result.Name = restriction.BaseTypeName.Name;
                }
            }
            else if (schemaType.Content is XmlSchemaSimpleTypeUnion)
            {
                var union = (XmlSchemaSimpleTypeUnion)schemaType.Content;
                if (union.BaseMemberTypes != null)
                    result.Name = union.BaseMemberTypes[0].Name;
                else if (union.BaseTypes != null)
                {
                    if (union.BaseTypes[0] is XmlSchemaSimpleType)
                    {
                        return GetDataType((XmlSchemaSimpleType)union.BaseTypes[0], schemaTypes, 0, nameSpace);
                    }
                    else
                    {
                        result.Name = union.BaseTypes[0].GetType().ToString();
                    }
                }
                else
                {
                    result.Name = "unknown(4)";
                }
            }
            else
            {
                result.Name = "unknown(3)";
            }

            return result;
        }

        public static IEnumerable<int> GetPatternFacetFieldLengths(string candidate)
        {
            if (string.IsNullOrWhiteSpace(candidate))
            {
                return Enumerable.Empty<int>();
            }

            var start = candidate.IndexOf("{") + 1;
            var forLen = candidate.IndexOf("}") - start;
            var intermediate = candidate.Substring(start, forLen);
            var results = intermediate.Split(',').ToList();

            return results.Select(x => int.Parse(x));
        }
    }
}
