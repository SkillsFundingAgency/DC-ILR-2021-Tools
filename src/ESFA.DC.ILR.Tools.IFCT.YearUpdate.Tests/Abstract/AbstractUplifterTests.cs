using System;
using System.Collections.Generic;
using System.Linq;
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

            // Act
            ApplyRule(m => m.TestProperty, uplifter, modelMock.Object);

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

            // Act
            ApplyRule(m => m.TestProperty, uplifter, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Once);
            modelMock.VerifySet(v => v.TestProperty = "TestPropertyValue".ToUpper(), Times.Once);
        }

        [Fact]
        public void ApplyChildRule_NullChildDoesNothing()
        {
            // Arrange
            TestChildModelClass testChildModelClassValue = null;
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestChildClass).Returns(testChildModelClassValue);
            modelMock.SetupSet(s => s.TestChildClass = It.IsAny<TestChildModelClass>()).Verifiable();

            var xxx = new TestChildModelUplifter();

            // Act
            ApplyChildRule(m => m.TestChildClass, xxx, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestChildClass, Times.Once);
            modelMock.VerifySet(v => v.TestChildClass = It.IsAny<TestChildModelClass>(), Times.Never);
        }

        [Fact]
        public void ApplyChildRule_ChildRuleIsAppliedToValue()
        {
            // Arrange
            TestChildModelClass testChildModelClassValue = new TestChildModelClass { ChildTestProperty = "Test String" };
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestChildClass).Returns(testChildModelClassValue);
            modelMock.SetupSet(s => s.TestChildClass = It.IsAny<TestChildModelClass>()).Verifiable();

            var xxx = new TestChildModelUplifter();

            // Act
            ApplyChildRule(m => m.TestChildClass, xxx, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestChildClass, Times.Once);
            modelMock.VerifySet(v => v.TestChildClass = It.IsAny<TestChildModelClass>(), Times.Once);
            testChildModelClassValue.ChildTestProperty.Should().Be("TEST STRING");
        }

        [Fact]
        public void ApplyGroupChildRule_NullChildDoesNothing()
        {
            // Arrange
            List<TestChildModelClass> testChildClassListValue = null;
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestChildClassList).Returns(testChildClassListValue);
            modelMock.SetupSet(s => s.TestChildClassList = It.IsAny<List<TestChildModelClass>>()).Verifiable();

            var testChildModelUplifter = new TestChildModelUplifter();

            // Act
            ApplyGroupChildRule(m => m.TestChildClassList, testChildModelUplifter, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Never);
            modelMock.VerifyGet(v => v.TestChildClass, Times.Never);
            modelMock.VerifyGet(v => v.TestChildClassList, Times.Once);
            modelMock.VerifySet(v => v.TestChildClassList = It.IsAny<List<TestChildModelClass>>(), Times.Never);
        }

        [Fact]
        public void ApplyGroupChildRule_GroupChildRuleIsAppliedToValue()
        {
            // Arrange
            List<TestChildModelClass> testChildClassListValue = new List<TestChildModelClass>
            {
                new TestChildModelClass { ChildTestProperty = "Test String One" },
                new TestChildModelClass { ChildTestProperty = "Test String Two" }
            };
            var modelMock = new Mock<TestModelClass>();
            modelMock.Setup(s => s.TestChildClassList).Returns(testChildClassListValue);
            modelMock.SetupSet(s => s.TestChildClassList = It.IsAny<List<TestChildModelClass>>()).Verifiable();

            var testChildModelUplifter = new TestChildModelUplifter();

            // Act
            ApplyGroupChildRule(m => m.TestChildClassList, testChildModelUplifter, modelMock.Object);

            // Assert
            modelMock.VerifyGet(v => v.TestProperty, Times.Never);
            modelMock.VerifyGet(v => v.TestChildClass, Times.Never);
            modelMock.VerifyGet(v => v.TestChildClassList, Times.Once);
            modelMock.VerifySet(v => v.TestChildClassList = It.IsAny<List<TestChildModelClass>>(), Times.Once);

            testChildClassListValue.Should().NotBeNull();
            testChildClassListValue.Should().NotBeEmpty();
            testChildClassListValue.Should().HaveCount(2);

            testChildClassListValue.First().ChildTestProperty.Should().Be("TEST STRING ONE");
            testChildClassListValue.Last().ChildTestProperty.Should().Be("TEST STRING TWO");
        }
    }
}
