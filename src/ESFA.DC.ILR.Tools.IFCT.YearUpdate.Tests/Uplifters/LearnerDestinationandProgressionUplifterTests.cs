using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class LearnerDestinationandProgressionUplifterTests
    {
        [Fact]
        public void LearnerDestinationandProgressionUplifter_CleanRunCallsAllChildObject()
        {
            // Arrange
            var learnerDestinationandProgressionDPOutcomeUplifter = new Mock<IUplifter<MessageLearnerDestinationandProgressionDPOutcome>>();

            var learnerDestinationandProgressionUplifter = new LearnerDestinationandProgressionUplifter(learnerDestinationandProgressionDPOutcomeUplifter.Object);

            var messageLearnerDestinationandProgression = new MessageLearnerDestinationandProgression();
            messageLearnerDestinationandProgression.DPOutcome.Add(new MessageLearnerDestinationandProgressionDPOutcome());

            // Act
            var result = learnerDestinationandProgressionUplifter.Uplift(messageLearnerDestinationandProgression);

            // Arrange
            result.Should().NotBeNull();
            learnerDestinationandProgressionDPOutcomeUplifter.Verify(v => v.Uplift(It.IsAny<MessageLearnerDestinationandProgressionDPOutcome>()), Times.Once);
        }
    }
}
