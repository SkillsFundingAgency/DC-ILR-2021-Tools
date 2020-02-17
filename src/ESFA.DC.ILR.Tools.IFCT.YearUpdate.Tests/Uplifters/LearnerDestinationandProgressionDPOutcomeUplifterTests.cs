using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerDestinationandProgressionDPOutcomeUplifterTests
    {
        [Fact]
        public void LearnerDestinationandProgressionDPOutcomeUplifter_CleanRunUpdatesDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();

            var learnerDestinationandProgressionDPOutcomeUplifter = new LearnerDestinationandProgressionDPOutcomeUplifter(ruleProvider);

            var messageLearnerDestinationandProgressionDPOutcome = new MessageLearnerDestinationandProgressionDPOutcome
            {
                OutStartDate = new DateTime(2019, 07, 01),
                OutEndDate = new DateTime(2019, 07, 02),
                OutCollDate = new DateTime(2019, 07, 03)
            };

            // Act
            var result = learnerDestinationandProgressionDPOutcomeUplifter.Process(messageLearnerDestinationandProgressionDPOutcome);

            // Assert
            result.Should().NotBeNull();
            result.OutStartDate.Should().Be(new DateTime(2020, 07, 01));
            result.OutEndDate.Should().Be(new DateTime(2020, 07, 02));
            result.OutCollDate.Should().Be(new DateTime(2020, 07, 03));
        }
    }
}
