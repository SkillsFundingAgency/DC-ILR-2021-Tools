using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Logging.Interfaces;
using ESFA.DC.Serialization.Interfaces;
using FluentAssertions;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class AnnualMapperTests
    {
        private readonly string sourcefileName = "sourceFile.xml";
        private readonly string targetfileName = "targetFile.xml";

        [Fact]
        public async Task AnnualMapper_WorkingRunReturnsTrueandLogs()
        {
            // Arrange
            var fileServiceMock = new Mock<IFileService>();
            var targetStream = new MemoryStream();
            fileServiceMock.Setup(c => c.OpenWriteStreamAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<CancellationToken>())).ReturnsAsync(targetStream);
            var xmlSerializationServiceMock = new Mock<IXmlSerializationService>();
            var iMapMock = new Mock<IMap<Loose.Previous.Message, Loose.Message>>();
            var loggerMock = new Mock<ILogger>();

            var annualMapper = new AnnualMapper(fileServiceMock.Object, xmlSerializationServiceMock.Object, iMapMock.Object, loggerMock.Object);

            // Act
            var result = await annualMapper.MapFileAsync(sourcefileName, targetfileName);

            // Assert
            result.Should().BeTrue();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyVerbose(It.IsAny<string>(), Times.Exactly(6)).Should().BeTrue();

            targetStream.Dispose();
        }

        [Fact]
        public async Task AnnualMapper_FailingRunReturnsFalseAndLogsFatal()
        {
            // Arrange
            var fileServiceMock = new Mock<IFileService>();
            var xmlSerializationServiceMock = new Mock<IXmlSerializationService>();
            var iMapMock = new Mock<IMap<Loose.Previous.Message, Loose.Message>>();
            var loggerMock = new Mock<ILogger>();

            var annualMapper = new AnnualMapper(fileServiceMock.Object, xmlSerializationServiceMock.Object, iMapMock.Object, loggerMock.Object);

            // Act
            var result = await annualMapper.MapFileAsync(sourcefileName, targetfileName);

            // Assert
            result.Should().BeFalse();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyFatal($"Failed mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
        }
    }
}
