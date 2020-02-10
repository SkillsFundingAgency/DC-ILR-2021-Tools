using System;
using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Rules
{
    public class StandardDateUplifterRuleTests
    {
        [Fact]
        public void StandardDateUplifterRule_DateTime_UpliftsAsExpected()
        {
            var rule = new StandardDateUplifterRule<DateTime>();

            var result = rule.Definition(new DateTime(2019, 1, 1));

            Assert.Equal(result, new DateTime(2020, 1, 1));
        }

        public static IEnumerable<object[]> NullableDateTimeData()
        {
            yield return new object[] { null, null };
            yield return new object[] { new DateTime(2019, 1, 1), new DateTime(2020, 1, 1) };
        }

        [Theory]
        [MemberData(nameof(NullableDateTimeData))]
        public void StandardDateUplifterRule_NullableDateTime_UpliftsAsExpected(DateTime? source, DateTime? expectedResult)
        {
            var rule = new StandardDateUplifterRule<DateTime?>();

            var result = rule.Definition(source);

            Assert.Equal(result, expectedResult);
        }
    }
}
