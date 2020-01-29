using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using FluentAssertions;
using Moq;
using System;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class MapperProviderTests
    {
        [Theory]
        [InlineData(true, "Hello there")]
        [InlineData(false, "Hello &#13;there")]
        public void StringMapper_SanitizeStringsRespectsConfig(bool sanitizeString, string expectedValue)
        {
            // Arrange
            var configMock = new Mock<IAnnualMapperConfiguration>();
            configMock.Setup(c => c.SanitizeStrings).Returns(sanitizeString);

            var mappingProvider = new MapperProvider(configMock.Object);
            var mapping = mappingProvider.GetMapper();

            var sourceString = "Hello &#13;there";

            // Act
            var targetString = mapping.Map<string>(sourceString);

            // Assert
            targetString.Should().Be(expectedValue);
        }

        [Fact]
        public void MessageHeaderCollectionDetailsMapper_AddsYearToPrepDate()
        {
            // Arrange
            var configMock = new Mock<IAnnualMapperConfiguration>();

            var mappingProvider = new MapperProvider(configMock.Object);
            var mapping = mappingProvider.GetMapper();

            var refDate = DateTime.Now;
            var mssageHeaderCollectionDetails = new Loose.Previous.MessageHeaderCollectionDetails { FilePreparationDate = refDate };

            // Act
            var targetMessageHeaderCollectionDetails = mapping.Map<Loose.MessageHeaderCollectionDetails>(mssageHeaderCollectionDetails);

            // Assert
            targetMessageHeaderCollectionDetails.FilePreparationDate.Should().Be(refDate.AddYears(1));
        }
    }
}
