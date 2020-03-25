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
                    var dateTime = (DateTime)(object)nullableDateTime.Value;

                    return (T)(object)UpliftYear(dateTime);
                }
            }

            if (typeof(T) == typeof(DateTime))
            {
                var dateTime = (DateTime)(object)value;
                return (T)(object)UpliftYear(dateTime);
            }

            return default(T);
        }

        private DateTime UpliftYear(DateTime dateTime)
        {
            dateTime = dateTime.AddYears(1);

            if (DateTime.IsLeapYear(dateTime.Year) && dateTime.Month == 2 && dateTime.Day == 28)
            {
                dateTime = dateTime.AddDays(1);
            }

            return dateTime;
        }
    }
}
