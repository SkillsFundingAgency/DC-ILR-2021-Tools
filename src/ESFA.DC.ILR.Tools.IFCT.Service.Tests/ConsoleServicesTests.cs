﻿using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Console;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using FluentAssertions;
using Moq;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class ConsoleServicesTests
    {
        private readonly string sourcefileName = "sourceFile.xml";
        private readonly string targetfileName = "targetFile.xml";

        [Fact]
        public void ConsoleService_ProcessFiles_NullParamaterThrowsArgumentNullException()
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();

            var consoleService = new ConsoleService(annualMapperMock.Object, null, null);
            FileConversionContext fileConversionContext = null;

            // Act & Assert
            Func<Task> action = async () => await consoleService.ProcessFilesAsync(fileConversionContext);
            action.Should().Throw<ArgumentNullException>();
        }

        [Theory]
        [InlineData(null, null, null, null)]
        [InlineData("sourceFile", null, null, null)]
        [InlineData(null, "targetFile", null, null)]
        [InlineData(null, null, "sourceFolder", null)]
        [InlineData(null, null, null, "targetFolder")]
        public void ConsoleService_ProcessFiles_InvalidFileConversionContextThrowsArgumentException(
            string sourceFile,
            string targetFile,
            string sourceFolder,
            string targetFolder)
        {
            // Arrange
            var annualMapperMock = new Mock<IAnnualMapper>();
            var fileServiceMock = new Mock<IFileService>();
            var xsdValidationMock = new Mock<IXsdValidationService>();

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object, xsdValidationMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourceFile,
                TargetFile = targetFile,
                SourceFolder = sourceFolder,
                TargetFolder = targetFolder
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
            var xsdValidationServiceMock = new Mock<IXsdValidationService>();
            xsdValidationServiceMock.Setup(c => c.Validate(It.IsAny<Stream>())).Verifiable();
            fileServiceMock.Setup(c => c.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>())).ReturnsAsync(false);

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object, xsdValidationServiceMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourcefileName,
                TargetFile = targetfileName,
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
            var xsdValidationServiceMock = new Mock<IXsdValidationService>();
            xsdValidationServiceMock.Setup(c => c.Validate(It.IsAny<Stream>())).Verifiable();
            fileServiceMock.Setup(c => c.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>())).ReturnsAsync(true);

            var consoleService = new ConsoleService(annualMapperMock.Object, fileServiceMock.Object, xsdValidationServiceMock.Object);
            FileConversionContext fileConversionContext = new FileConversionContext
            {
                SourceFile = sourcefileName,
                TargetFile = targetfileName,
            };

            // Act
            await consoleService.ProcessFilesAsync(fileConversionContext);

            // Assert
            xsdValidationServiceMock.Verify(v => v.Validate(It.IsAny<Stream>()), Times.Once);
            fileServiceMock.Verify(v => v.ExistsAsync(sourcefileName, null, It.IsAny<CancellationToken>()), Times.Once);
            annualMapperMock.Verify(v => v.MapFileAsync(sourcefileName, targetfileName), Times.Once);
        }
    }
}
