using System.Linq;
using ESFA.DC.ILR.Tools.IFCT.Anonymise;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.ReferenceProviders;
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
            var learnerAnonymiser = new LearnerAnonymiser(null, null);

            // Act
            var result = learnerAnonymiser.Process(null);

            // Assert
            result.Should().BeNull();
        }

        [Fact]
        public void LearnerAnonymiser_Process_MessageGetsAnonymised()
        {
            // Arrange
            var anonymiseLog = new AnonymiseLog();
            var learningReferenceProvider = new LearnerReferenceProvider(anonymiseLog);
            var ulnProvider = new ULNProvider(anonymiseLog);
            var learnerAnonymiser = new LearnerAnonymiser(ulnProvider, learningReferenceProvider);

            var messageLearner = new Loose.MessageLearner
            {
                AddLine1 = "Blah",
                AddLine3 = "Blah",
                LearnRefNumber = "123",
                ULN = 321
            };

            // Act
            var result = learnerAnonymiser.Process(messageLearner);

            // Assert
            result.Should().NotBeNull();
            result.Should().Equals(messageLearner);

            result.LearnRefNumber.Should().Equals("1");
            result.ULN.Should().Equals(9000000105);

            result.GivenNames.Should().Equals("GivenNames");
            result.FamilyName.Should().Equals("FamilyName");

            result.AddLine1.Should().Equals("Address line 1");
            result.AddLine2.Should().Equals("Address line 2");
            result.AddLine3.Should().Equals("Address Line 3");
            result.AddLine3.Should().Equals("Address Line 4");

            anonymiseLog.Log.Should().NotBeNull();
            anonymiseLog.Log.Should().NotBeEmpty();
            anonymiseLog.Log.Should().HaveCount(2);
        }

        [Fact]
        public void ULNProvider_Ignores_9999999999()
        {
            // Arrange
            var anonymiseLog = new AnonymiseLog();
            var ulnProvider = new ULNProvider(anonymiseLog);

            // Act
            var result = ulnProvider.ProvideNewReference(9999999999);

            // Assert
            result.Should().Be(9999999999);
            anonymiseLog.Log.Should().BeEmpty();
        }

        [Fact]
        public void ULNProvider_Creates_New_ULN_And_Logs()
        {
            // Arrange
            var anonymiseLog = new AnonymiseLog();
            var ulnProvider = new ULNProvider(anonymiseLog);

            // Act
            var result = ulnProvider.ProvideNewReference(123);

            // Assert
            result.Should().Be(9000000105);
            anonymiseLog.Log.Should().NotBeEmpty();
            anonymiseLog.Log.Should().HaveCount(1);
            anonymiseLog.Log.First().FieldName.Should().Be("ULN");
            anonymiseLog.Log.First().OldValue.Should().Be("123");
            anonymiseLog.Log.First().NewValue.Should().Be("9000000105");
        }

        [Fact]
        public void LearnerRefProvider_Creates_New_LearnerRef_And_Logs()
        {
            // Arrange
            var anonymiseLog = new AnonymiseLog();
            var learningReferenceProvider = new LearnerReferenceProvider(anonymiseLog);

            // Act
            var result = learningReferenceProvider.ProvideNewReference("123");

            // Assert
            result.Should().Be("1");
            anonymiseLog.Log.Should().NotBeEmpty();
            anonymiseLog.Log.Should().HaveCount(1);
            anonymiseLog.Log.First().FieldName.Should().Be("LearnRefNumber");
            anonymiseLog.Log.First().OldValue.Should().Be("123");
            anonymiseLog.Log.First().NewValue.Should().Be("1");
        }
    }
}
