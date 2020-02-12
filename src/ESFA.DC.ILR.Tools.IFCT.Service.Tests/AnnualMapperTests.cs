using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Interface;
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
            var yearUplifterMock = new Mock<IProcess<Loose.Message>>();
            yearUplifterMock.Setup(s => s.Process(It.IsAny<Loose.Message>())).Returns<Loose.Message>(x => x);
            var anonymiserMock = new Mock<IAnonymise<Loose.Message>>();
            anonymiserMock.Setup(s => s.Process(It.IsAny<Loose.Message>())).Returns<Loose.Message>(x => x);
            var anonymiseLogMock = new Mock<IAnonymiseLog>();
            anonymiseLogMock.SetupGet(s => s.Log).Returns(new List<IAnonymiseLogEntry>());

            var annualMapper = new AnnualMapper(fileServiceMock.Object, xmlSerializationServiceMock.Object, iMapMock.Object, yearUplifterMock.Object, anonymiserMock.Object, anonymiseLogMock.Object, loggerMock.Object);

            // Act
            var result = await annualMapper.MapFileAsync(sourcefileName, null, targetfileName, null);

            // Assert
            result.Should().BeTrue();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyVerbose(It.IsAny<string>(), Times.Exactly(8)).Should().BeTrue();

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

            var annualMapper = new AnnualMapper(fileServiceMock.Object, xmlSerializationServiceMock.Object, iMapMock.Object, null, null, null, loggerMock.Object);

            // Act
            var result = await annualMapper.MapFileAsync(sourcefileName, null, targetfileName, null);

            // Assert
            result.Should().BeFalse();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyFatal($"Failed mapping {sourcefileName} to {targetfileName}", Times.Once()).Should().BeTrue();
        }
    }
}
