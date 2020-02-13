using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryFAMUplifterTests
    {
        [Fact]
        public void LearnerLearningDeliveryLearningDeliveryFAMUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerLearningDeliveryLearningDeliveryFAMUplifter = new LearnerLearningDeliveryLearningDeliveryFAMUplifter(ruleProvider);

            var messageLearnerLearningDeliveryLearningDeliveryFAM = new MessageLearnerLearningDeliveryLearningDeliveryFAM
            {
                LearnDelFAMDateFrom = new DateTime(2019, 01, 08),
                LearnDelFAMDateTo = new DateTime(2019, 01, 09)
            };

            // Act
            var result = learnerLearningDeliveryLearningDeliveryFAMUplifter.Process(messageLearnerLearningDeliveryLearningDeliveryFAM);

            // Assert
            result.Should().NotBeNull();
            result.LearnDelFAMDateFrom.Should().Be(new DateTime(2020, 01, 08));
            result.LearnDelFAMDateTo.Should().Be(new DateTime(2020, 01, 09));
        }
    }
}
