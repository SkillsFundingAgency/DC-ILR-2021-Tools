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
    public class LearnerLearningDeliveryUplifterTests
    {
        [Fact]
        public void LearnerLearningDeliveryUplifter_CleanRunUpdatesDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var learnerLearningDeliveryUplifter = new LearnerLearningDeliveryUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearnerLearningDelivery = new MessageLearnerLearningDelivery
            {
                LearnStartDate = new DateTime(2000, 01, 21),
                OrigLearnStartDate = new DateTime(2000, 01, 22),
                LearnPlanEndDate = new DateTime(2000, 01, 23),
                LearnActEndDate = new DateTime(2000, 01, 24),
                AchDate = new DateTime(2000, 01, 25),
            };

            // Act
            var result = learnerLearningDeliveryUplifter.Process(messageLearnerLearningDelivery);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDelivery", "LearnStartDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDelivery", "OrigLearnStartDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDelivery", "LearnPlanEndDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDelivery", "LearnActEndDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDelivery", "AchDate"), Times.Once);

            result.Should().NotBeNull();

            result.LearnStartDate.Should().Be(new DateTime(2001, 01, 21));
            result.OrigLearnStartDate.Should().Be(new DateTime(2001, 01, 22));
            result.LearnPlanEndDate.Should().Be(new DateTime(2001, 01, 23));
            result.LearnActEndDate.Should().Be(new DateTime(2001, 01, 24));
            result.AchDate.Should().Be(new DateTime(2001, 01, 25));
        }
    }
}
