using EasyOPA.Set;
using System;
using System.Globalization;
using System.Xml;
using Tiny.Framework.Utilities;

namespace EasyOPA.Utility
{
    /// <summary>
    /// (xml) string utilities
    /// </summary>
    public static class StringExtensions
    {
        public static XmlDocument AsDocument(this string source)
        {
            var document = new XmlDocument();
            // parsing errors will cause this to fail..
            document.LoadXml(source);

            return document;
        }

        /// <summary>
        /// As string.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <returns>a batch operating year converted to a 'year' string</returns>
        public static string AsString(this BatchOperatingYear source)
        {
            // 0123
            // All
            // OY_1718
            var temp = source.ToString();
            var start = temp.Length == 7 ? 3 : 0;
            return source.ToString().Substring(start);
        }

        /// <summary>
        /// As operating year.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <returns>a valid batch operating year (or fails)</returns>
        public static BatchOperatingYear AsOperatingYear(this string source)
        {
            // note: this operation is safe as it will return 'not set' for any element not in the set 
            return FromSet<BatchOperatingYear>.Get($"OY_{source}");
        }

        /// <summary>
        /// As type of the operation / collection.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <returns>a batch operation type</returns>
        public static TypeOfCollection AsOperationType(this string source)
        {
            return FromSet<TypeOfCollection>.Get(source);
        }

        /// <summary>
        /// As a uk datetime.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <returns>a UK formatted datetime string - dd/MM/yyyy hh:mm(am/pm)</returns>
        public static string AsUKDatetime(this DateTime source)
        {
            return source.ToString("dd/MM/yyyy hh:mmtt");
        }

        /// <summary>
        /// As a uk date.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <returns>a UK formatted date string - dd/MM/yyyy</returns>
        public static string AsUKDate(this DateTime source)
        {
            return source.ToString("dd/MM/yyyy");
        }
    }
}
