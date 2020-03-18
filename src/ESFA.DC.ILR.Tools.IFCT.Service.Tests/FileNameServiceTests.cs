using System;
using FluentAssertions;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class FileNameServiceTests
    {
        [Fact]
        public void YearUpdateValidString()
        {
            var returns = FileNameService.YearUpdate("1920");
            returns.Should().Be("2021");
        }

        [Theory]
        [InlineData("")]
        [InlineData(null)]
        [InlineData("12345")]
        [InlineData("123")]
        [InlineData("abcd")]
        public void YearUpdateInvalidStringParameter(string s)
        {
            Action a = () => FileNameService.YearUpdate(s);
            a.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void SerialNumberUpdateValidInput()
        {
            string result = FileNameService.SerialNumberUpdate("01");
            result.Should().Be("99");
        }

        [Theory]
        [InlineData("")]
        [InlineData(null)]
        [InlineData("a")]
        [InlineData("ab")]
        [InlineData("abc")]
        [InlineData("1")]
        [InlineData("123")]
        public void SerialNumberUpdateInvalidInput(string number)
        {
            Action a = () => FileNameService.SerialNumberUpdate(number);
            a.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void DateUpdateValidDate()
        {
            string result = FileNameService.DateStampUpdate("20190101");
            result.Should().Be("20200101");
        }

        [Theory]
        [InlineData("")]
        [InlineData(null)]
        [InlineData("20191301")]
        [InlineData("20191232")]
        [InlineData("201912320")]
        [InlineData("2019123")]
        [InlineData("2019Jun10")]
        public void DateUpdateIvalidDate(string date)
        {
            Action result = () => FileNameService.DateStampUpdate(date);
            result.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void NameGenerationValidInput()
        {
            var sut = NewService();
            string result = sut.Generate("ILR-10006341-1920-20190210-120000-01");
            result.Should().Be("ILR-10006341-2021-20190210-120000-01");
        }

        [Theory]
        [InlineData("120000", "120001")]
        [InlineData("235959", "000000")]
        public void TimeStampUpdateValidInput(string input, string expected)
        {
            string result = FileNameService.TimeStampUpdate(input);
            result.Should().Be(expected);
        }

        [Theory]
        [InlineData("")]
        [InlineData(null)]
        [InlineData("1200000")]
        [InlineData("12000")]
        public void TimeStampUpdateInvalidInput(string date)
        {
            Action result = () => FileNameService.TimeStampUpdate(date);
            result.Should().Throw<ArgumentException>();
        }

        private FileNameService NewService()
        {
            return new FileNameService();
        }
    }
}
