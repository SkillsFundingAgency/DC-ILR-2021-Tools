using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Moq;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Abstract
{
    public class AbstractUplifterTests : AbstractUplifter<TestModelClass>
    {
        [Fact]
        public void ApplyRule_NullDoesNotSetProperty()
        {
            // Arrange
            string stringValue = null;
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestProperty).Returns(stringValue);
            modelMock.SetupSet(s => s.TestProperty = It.IsAny<string>()).Verifiable();

            Func<string, string> uplifter = (x) => x.ToUpper();

            Expression<Func<TestModelClass, string>> selector = m => m.TestProperty;

            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var props = new FieldUpdateProperties<TestModelClass, string>(
                yearUpdateConfiguration.Object.ShouldUpdateDate(typeof(TestModelClass).Name, "TestProperty"),
                s => s.TestProperty,
                uplifter);

            // Act
            ApplyRule(props, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Once);
            modelMock.VerifySet(v => v.TestProperty = It.IsAny<string>(), Times.Never);
        }

        [Fact]
        public void ApplyRule_RuleIsAppliedToValue()
        {
            // Arrange
            var stringValue = "TestPropertyValue";
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestProperty).Returns(stringValue);
            modelMock.SetupSet(s => s.TestProperty = It.IsAny<string>()).Verifiable();

            Func<string, string> uplifter = (x) => x.ToUpper();

            Expression<Func<TestModelClass, string>> selector = m => m.TestProperty;

            var yearUpdateConfiguration = new Mock<IYearUpdateConfiguration>();
            yearUpdateConfiguration.Setup(s => s.ShouldUpdateDate(It.IsAny<string>(), It.IsAny<string>())).Returns(true);

            var props = new FieldUpdateProperties<TestModelClass, string>(
                yearUpdateConfiguration.Object.ShouldUpdateDate(typeof(TestModelClass).Name, "TestProperty"),
                s => s.TestProperty,
                uplifter);

            // Act
            ApplyRule(props, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Once);
            modelMock.VerifySet(v => v.TestProperty = "TestPropertyValue".ToUpper(), Times.Once);
        }
    }
}
