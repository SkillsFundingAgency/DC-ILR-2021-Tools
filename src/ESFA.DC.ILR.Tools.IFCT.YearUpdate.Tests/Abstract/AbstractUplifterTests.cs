using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using FluentAssertions;
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
            var compiledSelector = selector.Compile();

            // Act
            ApplyCompiledRule(selector, compiledSelector, uplifter, modelMock.Object);

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
            var compiledSelector = selector.Compile();

            // Act
            ApplyCompiledRule(selector, compiledSelector, uplifter, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Once);
            modelMock.VerifySet(v => v.TestProperty = "TestPropertyValue".ToUpper(), Times.Once);
        }
    }
}
