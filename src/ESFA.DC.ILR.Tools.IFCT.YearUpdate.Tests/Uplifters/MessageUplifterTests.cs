using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class MessageUplifterTests
    {
        [Fact]
        public void MessageUplifter_CleanRunCallsAllChildObjects()
        {
            // Arrange
            var headerUplifter = new Mock<IUplifter<MessageHeader>>();
            var sourceFilesSourceFileUplifter = new Mock<IUplifter<MessageSourceFilesSourceFile>>();
            var learnerUplifter = new Mock<IUplifter<MessageLearner>>();
            var learnerDestinationandProgressionUplifter = new Mock<IUplifter<MessageLearnerDestinationandProgression>>();

            var messageUplifter = new MessageUplifter(headerUplifter.Object, sourceFilesSourceFileUplifter.Object, learnerUplifter.Object, learnerDestinationandProgressionUplifter.Object);

            var source = new Message { Header = new MessageHeader() };
            source.SourceFiles.Add(new MessageSourceFilesSourceFile());
            source.Learner.Add(new MessageLearner());
            source.LearnerDestinationandProgression.Add(new MessageLearnerDestinationandProgression());

            // Act
            var result = messageUplifter.Uplift(source);

            // Assert
            result.Should().NotBeNull();
            headerUplifter.Verify(v => v.Uplift(It.IsAny<MessageHeader>()), Times.Once);
            sourceFilesSourceFileUplifter.Verify(v => v.Uplift(It.IsAny<MessageSourceFilesSourceFile>()), Times.Once);
            learnerUplifter.Verify(v => v.Uplift(It.IsAny<MessageLearner>()), Times.Once);
            learnerDestinationandProgressionUplifter.Verify(v => v.Uplift(It.IsAny<MessageLearnerDestinationandProgression>()), Times.Once);
        }
    }
}
