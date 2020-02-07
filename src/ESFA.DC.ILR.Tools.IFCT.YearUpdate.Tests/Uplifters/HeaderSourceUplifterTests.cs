using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class HeaderSourceUplifterTests
    {
        [Fact]
        public void HeaderSourceUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var headerSourceUplifter = new HeaderSourceUplifter(ruleProvider);

            var messageHeaderSource = new MessageHeaderSource
            {
                DateTime = new DateTime(2019, 06, 08)
            };

            // Act
            var result = headerSourceUplifter.Uplift(messageHeaderSource);

            // Assert
            result.Should().NotBeNull();
            result.DateTime.Should().Be(new DateTime(2020, 06, 08));
        }
    }
}
