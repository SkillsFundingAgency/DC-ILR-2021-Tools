using ESFA.Common.Utility;
using System.Collections.Generic;
using System.Linq;

namespace ESFA.Common.Composition
{
    public sealed class StringDictionaryItem
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }

    /// <summary>
    /// Concrete dictionary class used by Friendly Text Converter
    /// </summary>
    public sealed class StringDictionary : List<StringDictionaryItem>
    {
        public bool Contains(string key)
        {
            return this.Any(x => Format.ComparesWith(x.Key, key));
        }

        public string GetValue(string key)
        {
            return Contains(key)
                ? this.First(x => Format.ComparesWith(x.Key, key)).Value
                : null;
        }
    }

}
