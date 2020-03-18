using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerLearningDeliveryUplifterTests
    {
        [Fact]
        public void LearnerLearningDeliveryUplifter_CleanRunUpdatesDatesAndCallAllChildObject()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerLearningDeliveryUplifter = new LearnerLearningDeliveryUplifter(ruleProvider);

            var messageLearnerLearningDelivery = new MessageLearnerLearningDelivery
            {
                LearnStartDate = new DateTime(2000, 01, 21),
                OrigLearnStartDate = new DateTime(2000, 01, 22),
                LearnPlanEndDate = new DateTime(2000, 01, 23),
                LearnActEndDate = new DateTime(2000, 01, 24),
                AchDate = new DateTime(2000, 01, 25),
            };
            messageLearnerLearningDelivery.LearningDeliveryFAM.Add(new MessageLearnerLearningDeliveryLearningDeliveryFAM());
            messageLearnerLearningDelivery.LearningDeliveryWorkPlacement.Add(new MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement());
            messageLearnerLearningDelivery.AppFinRecord.Add(new MessageLearnerLearningDeliveryAppFinRecord());

            // Act
            var result = learnerLearningDeliveryUplifter.Process(messageLearnerLearningDelivery);

            // Assert
            result.Should().NotBeNull();

            result.LearnStartDate.Should().Be(new DateTime(2001, 01, 21));
            result.OrigLearnStartDate.Should().Be(new DateTime(2001, 01, 22));
            result.LearnPlanEndDate.Should().Be(new DateTime(2001, 01, 23));
            result.LearnActEndDate.Should().Be(new DateTime(2001, 01, 24));
            result.AchDate.Should().Be(new DateTime(2001, 01, 25));
        }
    }
}
