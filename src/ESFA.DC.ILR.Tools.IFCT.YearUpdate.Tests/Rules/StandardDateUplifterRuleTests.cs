using System;
using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Rules
{
    public class StandardDateUplifterRuleTests
    {
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

        [Fact]
        public void StandardDateUplifterRule_DateTime_UpliftsAsExpected()
        {
            var rule = new StandardDateUplifterRule<DateTime>();

            var result = rule.Definition(new DateTime(2019, 1, 1));

            result.Year.Should().Equals(2020);
            result.Month.Should().Equals(1);
            result.Date.Should().Equals(1);
        }

        [Fact]
        public void DateTimeDefinitionMovesFromLeapYearCorrectly()
        {
            // Arrange
            var startDate = new DateTime(2016, 02, 29); // Start on the 29th Feb
            var lifter = new StandardDateUplifterRule<DateTime>();

            // Act
            var endDate = lifter.Definition(startDate);

            // Assert
            endDate.Year.Should().Equals(2017);
            endDate.Month.Should().Equals(2);
            endDate.Date.Should().Equals(28);
        }

        [Fact]
        public void DateTimeDefinitionMovesToLeapYearCorrectly()
        {
            // Arrange
            var startDate = new DateTime(2019, 02, 28); // Start on the 28th Feb
            var lifter = new StandardDateUplifterRule<DateTime>();

            // Act
            var endDate = lifter.Definition(startDate);

            // Assert
            endDate.Year.Should().Equals(2020);
            endDate.Month.Should().Equals(2);
            endDate.Date.Should().Equals(29);
        }

        [Fact]
        public void NullableDateTimeDefinitionMovesFromLeapYearCorrectly()
        {
            // Arrange
            var startDate = new DateTime(2016, 02, 29); // Start on the 29th Feb
            var lifter = new StandardDateUplifterRule<DateTime?>();

            // Act
            var endDate = lifter.Definition(startDate);

            // Assert
            endDate.HasValue.Should().BeTrue();
            endDate.Value.Year.Should().Equals(2017);
            endDate.Value.Month.Should().Equals(2);
            endDate.Value.Date.Should().Equals(28);
        }

        [Fact]
        public void NullableDateTimeDefinitionMovesToLeapYearCorrectly()
        {
            // Arrange
            var startDate = new DateTime(2019, 02, 28); // Start on the 28th Feb
            var lifter = new StandardDateUplifterRule<DateTime?>();

            // Act
            var endDate = lifter.Definition(startDate);

            // Assert
            endDate.HasValue.Should().BeTrue();
            endDate.Value.Year.Should().Equals(2020);
            endDate.Value.Month.Should().Equals(2);
            endDate.Value.Date.Should().Equals(29);
        }
    }
}
