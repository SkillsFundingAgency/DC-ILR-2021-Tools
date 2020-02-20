using ESFA.DC.ILR.Tools.IFCT.Anonymise;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers;
using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Anonymisers
{
    public class LearnerAnonymiserTests
    {
        [Fact]
        public void LearnerAnonymiser_Process_NullReturnsNull()
        {
            // Arrange
            var learnerAnonymiser = new LearnerAnonymiser(null);

            // Act
            var result = learnerAnonymiser.Process(null);

            // Assert
            result.Should().BeNull();
        }

        [Fact]
        public void LearnerAnonymiser_Process_MessageGetsAnonimised()
        {
            // Arrange
            var anonymiseLog = new AnonymiseLog();
            var learnerAnonymiser = new LearnerAnonymiser(anonymiseLog);

            var messageLearner = new Loose.MessageLearner
            {
                AddLine1 = "Blah",
                AddLine3 = "Blah"
            };

            // Act
            var result = learnerAnonymiser.Process(messageLearner);

            // Assert
            result.Should().NotBeNull();
            result.Should().Equals(messageLearner);

            result.LearnRefNumber.Should().Equals("1");
            result.ULN.Should().Equals(9000000105);

            result.FamilyName.Should().Equals("Mary Jane");
            result.GivenNames.Should().Equals("Sméth");

            result.AddLine1.Should().Equals("18 Address line road");
            result.AddLine2.Should().BeNull();
            result.AddLine3.Should().Equals("Address Line 3");
            result.AddLine4.Should().BeNull();

            anonymiseLog.Log.Should().NotBeNull();
            anonymiseLog.Log.Should().NotBeEmpty();
            anonymiseLog.Log.Should().HaveCount(2);
        }
    }
}
