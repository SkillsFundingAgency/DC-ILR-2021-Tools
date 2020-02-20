using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Xml.Schema;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Logging.Interfaces;
using ESFA.DC.Serialization.Interfaces;
using FluentAssertions;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class FileConversionOrchestratorTests
    {
        private readonly string sourcefileName = "sourceFile.xml";
        private readonly string targetfolderName = @"C:\";

        [Fact]
        public async Task FileConversionOrchestrator_WorkingRunReturnsTrueandLogs()
        {
            // Arrange
            var fileServiceMock = new Mock<IFileService>();
            var targetStream = new MemoryStream();
            fileServiceMock.Setup(c => c.OpenReadStreamAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<CancellationToken>())).ReturnsAsync(targetStream);
            fileServiceMock.Setup(c => c.OpenWriteStreamAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<CancellationToken>())).ReturnsAsync(targetStream);
            var fileNameServiceMock = new Mock<IFileNameService>();
            var xsdValidationMock = new Mock<IXsdValidationService>();
            xsdValidationMock.Setup(c => c.Validate(It.IsAny<Stream>(), It.IsAny<XmlSchemaSet>(), It.IsAny<ValidationEventHandler>())).Verifiable();
            var xmlProviderMock = new Mock<IXmlSchemaProvider>();
            xmlProviderMock.Setup(p => p.Provide()).Returns(new XmlSchema());
            var validationErrorMock = new Mock<IValidationErrorHandler>();
            var xmlSerializationServiceMock = new Mock<IXmlSerializationService>();
            var iMapMock = new Mock<IMap<Loose.Previous.Message, Loose.Message>>();
            var loggerMock = new Mock<ILogger>();
            var yearUplifterMock = new Mock<IProcess<Loose.Message>>();
            yearUplifterMock.Setup(s => s.Process(It.IsAny<Loose.Message>())).Returns<Loose.Message>(x => x);
            var anonymiserMock = new Mock<IAnonymise<Loose.Message>>();
            anonymiserMock.Setup(s => s.Process(It.IsAny<Loose.Message>())).Returns<Loose.Message>(x => x);
            var anonymiseLogMock = new Mock<IAnonymiseLog>();
            anonymiseLogMock.SetupGet(s => s.Log).Returns(new List<IAnonymiseLogEntry>());

            var fileConversionOrchestrator = new FileConversionOrchestrator(
                fileServiceMock.Object,
                fileNameServiceMock.Object,
                xsdValidationMock.Object,
                xmlProviderMock.Object,
                validationErrorMock.Object,
                xmlSerializationServiceMock.Object,
                iMapMock.Object,
                yearUplifterMock.Object,
                anonymiserMock.Object,
                anonymiseLogMock.Object,
                loggerMock.Object);

            // Act
            var result = await fileConversionOrchestrator.MapFileAsync(sourcefileName, null, targetfolderName);

            // Assert
            result.Should().BeTrue();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} into {targetfolderName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyVerbose(It.IsAny<string>(), Times.Exactly(8)).Should().BeTrue();

            targetStream.Dispose();
        }

        [Fact]
        public async Task FileConversionOrchestrator_FailingRunReturnsFalseAndLogsFatal()
        {
            // Arrange
            var fileServiceMock = new Mock<IFileService>();
            var xsdValidationMock = new Mock<IXsdValidationService>();
            var xmlProviderMock = new Mock<IXmlSchemaProvider>();
            var validationErrorMock = new Mock<IValidationErrorHandler>();
            var xmlSerializationServiceMock = new Mock<IXmlSerializationService>();
            var iMapMock = new Mock<IMap<Loose.Previous.Message, Loose.Message>>();
            var loggerMock = new Mock<ILogger>();

            var fileConversionOrchestrator = new FileConversionOrchestrator(
                fileServiceMock.Object,
                null,
                xsdValidationMock.Object,
                xmlProviderMock.Object,
                validationErrorMock.Object,
                xmlSerializationServiceMock.Object,
                iMapMock.Object,
                null,
                null,
                null,
                loggerMock.Object);

            // Act
            var result = await fileConversionOrchestrator.MapFileAsync(sourcefileName, null, targetfolderName);

            // Assert
            result.Should().BeFalse();
            loggerMock.VerifyInfo($"Mapping {sourcefileName} into {targetfolderName}", Times.Once()).Should().BeTrue();
            loggerMock.VerifyFatal($"Failed mapping {sourcefileName} into {targetfolderName}", Times.Once()).Should().BeTrue();
        }
    }
}
