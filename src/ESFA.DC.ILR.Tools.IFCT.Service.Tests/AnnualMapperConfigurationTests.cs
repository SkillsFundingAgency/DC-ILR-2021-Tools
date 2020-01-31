using ESFA.DC.Logging.Interfaces;
using FluentAssertions;
using Microsoft.Extensions.Configuration;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class AnnualMapperConfigurationTests
    {
        [Fact]
        public void AnnualMapperConfiguration_Constructor_LogsConfig()
        {
            // Arrange
            var loggerMock = new Mock<ILogger>();

            var configurationMock = new Mock<IConfiguration>();
            configurationMock.SetupGet(p => p[AnnualMapperConfiguration.SanitizeStringsId]).Returns("True");

            // Act
            var annualMapperConfiguration = new AnnualMapperConfiguration(configurationMock.Object, loggerMock.Object);

            // Assert
            var expectedLogString = $"Configuration: {AnnualMapperConfiguration.SanitizeStringsId}=[True]";
            loggerMock.VerifyInfo(expectedLogString, Times.Once()).Should().BeTrue();
        }

        [Theory]
        [InlineData("True", true)]
        [InlineData("False", false)]
        [InlineData("", true)]
        [InlineData(null, true)]
        public void AnnualMapperConfiguration_SanitizeStrings_RespectsIConfigValue(string iConfigValue, bool expectedResult)
        {
            // Arrange
            var loggerMock = new Mock<ILogger>();

            var configurationMock = new Mock<IConfiguration>();
            configurationMock.SetupGet(p => p[AnnualMapperConfiguration.SanitizeStringsId]).Returns(iConfigValue);

            var annualMapperConfiguration = new AnnualMapperConfiguration(configurationMock.Object, loggerMock.Object);

            // Act
            var result = annualMapperConfiguration.SanitizeStrings;

            // Assert
            result.Should().Be(expectedResult);
        }
    }
}
