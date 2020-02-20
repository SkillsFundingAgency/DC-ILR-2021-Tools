using System;
using System.ComponentModel;
using System.Linq;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// indentation
    /// </summary>
    public enum Indentation
    {
        /// <summary>
        /// The first level
        /// </summary>
        [Description("\t")]
        FirstLevel,

        /// <summary>
        /// The second level
        /// </summary>
        [Description("\t\t")]
        SecondLevel
    }

    /// <summary>
    /// Class Indent Format.
    /// </summary>
    public static class IndentFormat
    {
        public static string AsString(this Indentation source)
        {
            return GetAttribute<DescriptionAttribute>(source).Description;
        }

        public static TAttribute GetAttribute<TAttribute>(this Enum source)
            where TAttribute : Attribute
        {
            var enumType = source.GetType();
            var name = Enum.GetName(enumType, source);
            return enumType.GetField(name)
                .GetCustomAttributes(false)
                .OfType<TAttribute>()
                .SingleOrDefault();
        }
    }
}
