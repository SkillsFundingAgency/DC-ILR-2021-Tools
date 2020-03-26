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
    public class LearnerLearnerEmploymentStatusUplifterTests
    {
        [Fact]
        public void LearnerLearnerEmploymentStatusUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var learnerLearnerEmploymentStatusUplifter = new LearnerLearnerEmploymentStatusUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearnerLearnerEmploymentStatus = new MessageLearnerLearnerEmploymentStatus
            {
                DateEmpStatApp = new DateTime(2019, 01, 02)
            };

            // Act
            var result = learnerLearnerEmploymentStatusUplifter.Process(messageLearnerLearnerEmploymentStatus);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearnerEmploymentStatus", "DateEmpStatApp"), Times.Once);

            result.Should().NotBeNull();

            result.DateEmpStatApp.Should().Be(new DateTime(2020, 01, 02));
        }
    }
}
