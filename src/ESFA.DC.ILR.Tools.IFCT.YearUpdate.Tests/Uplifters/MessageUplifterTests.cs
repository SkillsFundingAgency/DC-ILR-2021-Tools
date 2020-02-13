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
            var messageUplifter = new MessageUplifter();

            var source = new Message { Header = new MessageHeader() };
            source.SourceFiles.Add(new MessageSourceFilesSourceFile());
            source.Learner.Add(new MessageLearner());
            source.LearnerDestinationandProgression.Add(new MessageLearnerDestinationandProgression());

            // Act
            var result = messageUplifter.Process(source);

            // Assert
            result.Should().NotBeNull();
        }
    }
}
