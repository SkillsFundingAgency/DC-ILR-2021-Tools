using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerLearnerEmploymentStatusUplifterTests
    {
        [Fact]
        public void LearnerLearnerEmploymentStatusUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerLearnerEmploymentStatusUplifter = new LearnerLearnerEmploymentStatusUplifter(ruleProvider);

            var messageLearnerLearnerEmploymentStatus = new MessageLearnerLearnerEmploymentStatus
            {
                DateEmpStatApp = new DateTime(2019, 01, 02)
            };

            // Act
            var result = learnerLearnerEmploymentStatusUplifter.Process(messageLearnerLearnerEmploymentStatus);

            // Assert
            result.Should().NotBeNull();
            result.DateEmpStatApp.Should().Be(new DateTime(2020, 01, 02));
        }
    }
}
