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
        public void LearnerUplifter_CleanRunUpdatesDatesAndCallAllChildObject()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerLearnerEmploymentStatusUplifter = new Mock<IUplifter<MessageLearnerLearnerEmploymentStatus>>();
            var learnerLearningDeliveryUplifter = new Mock<IUplifter<MessageLearnerLearningDelivery>>();

            var learnerUplifter = new LearnerUplifter(ruleProvider, learnerLearnerEmploymentStatusUplifter.Object, learnerLearningDeliveryUplifter.Object);

            var messageLearner = new MessageLearner
            {
                DateOfBirth = new DateTime(2000, 01, 02),
            };
            messageLearner.LearnerEmploymentStatus.Add(new MessageLearnerLearnerEmploymentStatus());
            messageLearner.LearningDelivery.Add(new MessageLearnerLearningDelivery());

            // Act
            var result = learnerUplifter.Uplift(messageLearner);

            // Assert
            result.Should().NotBeNull();
            result.DateOfBirth.Should().Be(new DateTime(2001, 01, 02));
            learnerLearnerEmploymentStatusUplifter.Verify(v => v.Uplift(It.IsAny<MessageLearnerLearnerEmploymentStatus>()), Times.Once);
            learnerLearningDeliveryUplifter.Verify(v => v.Uplift(It.IsAny<MessageLearnerLearningDelivery>()), Times.Once);
        }
    }
}
