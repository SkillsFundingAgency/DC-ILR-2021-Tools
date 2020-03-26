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
    public class LearnerLearningDeliveryAppFinRecordUplifterTests
    {
        [Fact]
        public void LearnerLearningDeliveryAppFinRecordUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var learnerLearningDeliveryAppFinRecordUplifter = new LearnerLearningDeliveryAppFinRecordUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageLearnerLearningDeliveryAppFinRecord = new MessageLearnerLearningDeliveryAppFinRecord
            {
                AFinDate = new DateTime(2019, 01, 02)
            };

            // Act
            var result = learnerLearningDeliveryAppFinRecordUplifter.Process(messageLearnerLearningDeliveryAppFinRecord);

            // Assert
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageLearnerLearningDeliveryAppFinRecord", "AFinDate"), Times.Once);

            result.Should().NotBeNull();

            result.AFinDate.Should().Be(new DateTime(2020, 01, 02));
        }
    }
}
