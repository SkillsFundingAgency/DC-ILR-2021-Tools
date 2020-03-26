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
    public class LearnerDestinationAndProgressionDPOutcomeUplifterTests
    {
        [Fact]
        public void LearnerDestinationAndProgressionDPOutcomeUplifter_CleanRunUpdatesDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var learnerDestinationAndProgressionDPOutcomeUplifter = new LearnerDestinationandProgressionDPOutcomeUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearnerDestinationAndProgressionDPOutcome = new MessageLearnerDestinationandProgressionDPOutcome
            {
                OutStartDate = new DateTime(2019, 07, 01),
                OutEndDate = new DateTime(2019, 07, 02),
                OutCollDate = new DateTime(2019, 07, 03)
            };

            // Act
            var result = learnerDestinationAndProgressionDPOutcomeUplifter.Process(messageLearnerDestinationAndProgressionDPOutcome);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerDestinationandProgressionDPOutcome", "OutStartDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerDestinationandProgressionDPOutcome", "OutEndDate"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerDestinationandProgressionDPOutcome", "OutCollDate"), Times.Once);

            result.Should().NotBeNull();

            result.OutStartDate.Should().Be(new DateTime(2020, 07, 01));
            result.OutEndDate.Should().Be(new DateTime(2020, 07, 02));
            result.OutCollDate.Should().Be(new DateTime(2020, 07, 03));
        }
    }
}
