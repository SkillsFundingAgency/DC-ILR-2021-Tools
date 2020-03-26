using FluentAssertions;
using Microsoft.Extensions.Configuration;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Configuration
{
    public class YearUpdateConfigurationTests
    {
        [Fact]
        public void NoSettingsReturnsFalse()
        {
            // Arrange
            var configuration = new Mock<IConfiguration>();
            var yearUpdateConfiguration = new YearUpdateConfiguration(configuration.Object, null);

            // Act
            var updateData = yearUpdateConfiguration.ShouldUpdateDate("method", "object");

            // Assert
            updateData.Should().BeFalse();
        }

        [Fact]
        public void DefaultTrueReturnsTrue()
        {
            // Arrange
            var configuration = new Mock<IConfiguration>();
            configuration.Setup(s => s["DateUplift:Default"]).Returns("true");

            var yearUpdateConfiguration = new YearUpdateConfiguration(configuration.Object, null);

            // Act
            var updateData = yearUpdateConfiguration.ShouldUpdateDate("method", "object");

            // Assert
            updateData.Should().BeTrue();
        }

        [Fact]
        public void DefaultTrueMethodObjectFalseReturnsFalse()
        {
            // Arrange
            var configuration = new Mock<IConfiguration>();
            configuration.Setup(s => s["DateUplift:Default"]).Returns("true");
            configuration.Setup(s => s["DateUplift:method:object"]).Returns("false");

            var yearUpdateConfiguration = new YearUpdateConfiguration(configuration.Object, null);

            // Act
            var updateData = yearUpdateConfiguration.ShouldUpdateDate("method", "object");

            // Assert
            updateData.Should().BeFalse();
        }
    }
}
