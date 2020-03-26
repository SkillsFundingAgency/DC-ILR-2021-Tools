using ESFA.DC.ILR.Tools.IFCT.Service.Extension;
using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class StringExtensionsTests
    {
        [Theory]
        [InlineData("Hello &#13;there", "Hello there")]
        [InlineData("Hello there", "Hello there")]
        public void StringExtensions_SanitizeStrings_RemovesUnwantedChars(string source, string expectedValue)
        {
            // Act
            var targetString = source.Sanitize();

            // Assert
            targetString.Should().Be(expectedValue);
        }
    }
}
