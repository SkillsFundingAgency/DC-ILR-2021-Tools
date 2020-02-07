using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
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

            var headerCollectionDetailsUplifter = new HeaderCollectionDetailsUplifter(ruleProvider);

            var messageHeaderCollectionDetails = new MessageHeaderCollectionDetails
            {
                FilePreparationDate = new DateTime(2019, 06, 07)
            };

            // Act
            var result = headerCollectionDetailsUplifter.Uplift(messageHeaderCollectionDetails);

            // Assert
            result.Should().NotBeNull();
            result.FilePreparationDate.Should().Be(new DateTime(2020, 06, 07));
        }
    }
}
