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
    public class SourceFilesSourceFileUplifterTests
    {
        [Fact]
        public void SourceFilesSourceFileUplifter_CleanRunShouldIncrementDates()
        {
            // Arrange
            var ruleProvider = new RuleProvider();
            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var sourceFilesSourceFileUplifter = new SourceFilesSourceFileUplifter(ruleProvider, yearUpdateConfiguration.Object);

            var messageSourceFilesSourceFile = new MessageSourceFilesSourceFile
            {
                DateTime = new DateTime(2019, 06, 10),
                FilePreparationDate = new DateTime(2019, 06, 11)
            };

            // Act
            var result = sourceFilesSourceFileUplifter.Process(messageSourceFilesSourceFile);

            // Arrange
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageSourceFilesSourceFile", "DateTime"), Times.Once);
            yearUpdateConfiguration.Verify(v => v.ShouldUpdateDate("MessageSourceFilesSourceFile", "FilePreparationDate"), Times.Once);

            result.Should().NotBeNull();

            result.DateTime.Should().Be(new DateTime(2020, 06, 10));
            result.FilePreparationDate.Should().Be(new DateTime(2020, 06, 11));
        }
    }
}
