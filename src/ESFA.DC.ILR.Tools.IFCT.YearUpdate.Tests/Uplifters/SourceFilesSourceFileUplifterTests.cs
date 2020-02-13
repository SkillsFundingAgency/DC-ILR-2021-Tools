using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
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

            var sourceFilesSourceFileUplifter = new SourceFilesSourceFileUplifter(ruleProvider);

            var messageSourceFilesSourceFile = new MessageSourceFilesSourceFile
            {
                DateTime = new DateTime(2019, 06, 10),
                FilePreparationDate = new DateTime(2019, 06, 11)
            };

            // Act
            var result = sourceFilesSourceFileUplifter.Process(messageSourceFilesSourceFile);

            // Arrange
            result.Should().NotBeNull();
            result.DateTime.Should().Be(new DateTime(2020, 06, 10));
            result.FilePreparationDate.Should().Be(new DateTime(2020, 06, 11));
        }
    }
}
