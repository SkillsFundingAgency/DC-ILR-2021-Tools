using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Console;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using FluentAssertions;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class ConsoleServicesTests
    {
        private readonly string sourcefileName = "sourceFile.xml";
        private readonly string targetfileName = "targetFile.xml";
        private readonly string targetFilePath = @"C:\";

        [Fact]
        public void ConsoleService_ProcessFiles_NullParamaterThrowsArgumentNullException()
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();

            var consoleService = new ConsoleService(annualMapperMock.Object, null);
            FileConversionContext fileConversionContext = null;

            // Act & Assert
            Func<Task> action = async () => await consoleService.ProcessFilesAsync(fileConversionContext);
            action.Should().Throw<ArgumentNullException>();
        }

        [Theory]
        [InlineData(null, null, null)]
        [InlineData("sourceFile", null, null)]
        [InlineData(null, "sourceFolder", null)]
        [InlineData(null, null, "targetFolder")]
        public void ConsoleService_ProcessFiles_InvalidFileConversionContextThrowsArgumentException(
            string sourceFile,
            string sourceFolder,
            string targetFolder)
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();
            var fileNameServiceMock = new Mock<IFileNameService>();
            var fileServiceMock = new Mock<IFileService>();

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourceFile,
                SourceFolder = sourceFolder,
                TargetFolder = targetFolder,
            };

            // Act & Assert
            Func<Task> action = async () => await consoleService.ProcessFilesAsync(fileConversionContext);
            action.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void ConsoleService_ProcessFiles_MissingSourceFileThrowsArgumentException()
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();
            var fileServiceMock = new Mock<IFileService>();

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourcefileName,
                TargetFolder = targetFilePath,
            };

            // Act
            Func<Task> action = async () => await consoleService.ProcessFilesAsync(fileConversionContext);
            action.Should().Throw<ArgumentException>();

            // Assert
            fileServiceMock.Verify(v => v.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>()), Times.Once);
        }

        [Fact]
        public async Task ConsoleService_ProcessFiles_ValidFilesCallMapFileAsync()
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();
            var fileServiceMock = new Mock<IFileService>();

            fileServiceMock.Setup(c => c.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>())).ReturnsAsync(true);

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourcefileName,
                TargetFolder = targetFilePath,
            };

            // Act
            await consoleService.ProcessFilesAsync(fileConversionContext);

            // Assert
            fileServiceMock.Verify(v => v.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>()), Times.Once);
            annualMapperMock.Verify(v => v.MapFileAsync(sourcefileName, string.Empty, targetFilePath), Times.Once);
        }
    }
}
