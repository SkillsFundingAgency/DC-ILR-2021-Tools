using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters;
using FluentAssertions;
using Loose;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Uplifters
{
    public class HeaderUplifterTests
    {
        [Fact]
        public void HeaderUplifter_CleanRunCallsAllChildObjects()
        {
            // Arrange
            var collectionDetailsUplifter = new Mock<IUplifter<MessageHeaderCollectionDetails>>();
            var headerSourceUplifter = new Mock<IUplifter<MessageHeaderSource>>();

            var headerUplifter = new HeaderUplifter(collectionDetailsUplifter.Object, headerSourceUplifter.Object);

            var source = new MessageHeader();
            source.CollectionDetails = new MessageHeaderCollectionDetails();
            source.Source = new MessageHeaderSource();

            // Act
            var result = headerUplifter.Uplift(source);

            // Assert
            result.Should().NotBeNull();
            collectionDetailsUplifter.Verify(v => v.Uplift(It.IsAny<MessageHeaderCollectionDetails>()), Times.Once);
            headerSourceUplifter.Verify(v => v.Uplift(It.IsAny<MessageHeaderSource>()), Times.Once);
        }
    }
}
