using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class MapperProviderTests
    {
        [Fact]
        public void MapperProvider_ProvidesMap()
        {
            // Arrange
            var mappingProvider = new MapperProvider(null);

            // Act
            var mapping = mappingProvider.GetMapper();

            // Assert
            mapping.Should().NotBeNull();
            mapping.ConfigurationProvider.Should().NotBeNull();
            mapping.ConfigurationProvider.GetAllTypeMaps().Length.Should().Be(24);
        }
    }
}
