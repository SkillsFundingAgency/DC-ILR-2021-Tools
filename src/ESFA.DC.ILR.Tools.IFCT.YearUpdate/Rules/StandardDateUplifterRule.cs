using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules
{
    public class StandardDateUplifterRule<T> : IRule<T>
    {
        public T Definition(T value)
        {
            if (typeof(T) == typeof(DateTime?))
            {
                var nullableDateTime = value as DateTime?;
                if (nullableDateTime != null && nullableDateTime.HasValue)
                {
                    return (T)(object)nullableDateTime.Value.AddYears(1);
                }
            }

            if (typeof(T) == typeof(DateTime))
            {
                var dateTime = (DateTime)(object)value;
                return (T)(object)dateTime.AddYears(1);
            }

            return default(T);
        }
    }
}
