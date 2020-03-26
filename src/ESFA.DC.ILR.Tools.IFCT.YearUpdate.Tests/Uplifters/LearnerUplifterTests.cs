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
    public class LearnerUplifterTests
    {
        [Fact]
        public void LearnerUplifter_CleanRunUpdatesDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var learnerUplifter = new LearnerUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearner = new MessageLearner
            {
                DateOfBirth = new DateTime(2000, 01, 02),
            };

            // Act
            var result = learnerUplifter.Process(messageLearner);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearner", "DateOfBirth"), Times.Once);
            result.Should().NotBeNull();
            result.DateOfBirth.Should().Be(new DateTime(2001, 01, 02));
        }

        [Fact]
        public void LearnerUplifter_DisabledRunDoesNotUpdatesDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(false);

            var learnerUplifter = new LearnerUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearner = new MessageLearner
            {
                DateOfBirth = new DateTime(2000, 01, 02),
            };
            messageLearner.LearnerEmploymentStatus.Add(new MessageLearnerLearnerEmploymentStatus());
            messageLearner.LearningDelivery.Add(new MessageLearnerLearningDelivery());

            // Act
            var result = learnerUplifter.Process(messageLearner);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearner", "DateOfBirth"), Times.Once);
            result.Should().NotBeNull();
            result.DateOfBirth.Should().Be(new DateTime(2000, 01, 02));
        }
    }
}
