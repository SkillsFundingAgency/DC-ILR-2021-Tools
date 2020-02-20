using System.Collections.Generic;
using System.Linq;

namespace XML2SQL
{
    public static class SQLItemListExtension
    {
        public static TSQLItem Get<TSQLItem>(this IEnumerable<TSQLItem> source, string itemName) 
            where TSQLItem : ISQLNamedItem
        {
            return source.FirstOrDefault(x => x.Name == itemName);
        }

        public static string AsString<TSQLItem>(this IEnumerable<TSQLItem> source)
            where TSQLItem : ISQLNamedItem
        {
            return string.Join(",", source.Select(x => x.Name));
        }
    }
}
