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
    public class HeaderCollectionDetailsUplifterTests
    {
        [Fact]
        public void HeaderCollectionDetailsUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var headerCollectionDetailsUplifter = new HeaderCollectionDetailsUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageHeaderCollectionDetails = new MessageHeaderCollectionDetails
            {
                FilePreparationDate = new DateTime(2019, 06, 07)
            };

            // Act
            var result = headerCollectionDetailsUplifter.Process(messageHeaderCollectionDetails);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageHeaderCollectionDetails", "FilePreparationDate"), Times.Once);
            result.Should().NotBeNull();
            result.FilePreparationDate.Should().Be(new DateTime(2020, 06, 07));
        }
    }
}
