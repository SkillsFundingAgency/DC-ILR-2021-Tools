using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifterTests
    {
        [Fact]
        public void LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter = new LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter(ruleProvider);

            var messageLearnerLearningDeliveryLearningDeliveryWorkPlacement = new MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement
            {
                WorkPlaceStartDate = new DateTime(2019, 01, 10),
                WorkPlaceEndDate = new DateTime(2019, 01, 11)
            };

            // Act
            var result = learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter.Process(messageLearnerLearningDeliveryLearningDeliveryWorkPlacement);

            // Assert
            result.Should().NotBeNull();
            result.WorkPlaceStartDate.Should().Be(new DateTime(2020, 01, 10));
            result.WorkPlaceEndDate.Should().Be(new DateTime(2020, 01, 11));
        }
    }
}
