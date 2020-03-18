using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
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

            var learnerUplifter = new LearnerUplifter(ruleProvider);

            var messageLearner = new MessageLearner
            {
                DateOfBirth = new DateTime(2000, 01, 02),
            };
            messageLearner.LearnerEmploymentStatus.Add(new MessageLearnerLearnerEmploymentStatus());
            messageLearner.LearningDelivery.Add(new MessageLearnerLearningDelivery());

            // Act
            var result = learnerUplifter.Process(messageLearner);

            // Assert
            result.Should().NotBeNull();
            result.DateOfBirth.Should().Be(new DateTime(2001, 01, 02));
        }
    }
}
