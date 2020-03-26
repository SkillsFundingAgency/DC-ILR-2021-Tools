using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Moq;
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
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var headerSourceUplifter = new HeaderSourceUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageHeaderSource = new MessageHeaderSource
            {
                DateTime = new DateTime(2019, 06, 08)
            };

            // Act
            var result = headerSourceUplifter.Process(messageHeaderSource);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageHeaderSource", "DateTime"), Times.Once);
            result.Should().NotBeNull();
            result.DateTime.Should().Be(new DateTime(2020, 06, 08));
        }
    }
}
