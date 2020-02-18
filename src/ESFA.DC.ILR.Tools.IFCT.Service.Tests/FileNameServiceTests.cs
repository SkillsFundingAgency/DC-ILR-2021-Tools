using FluentAssertions;
using System;
using Xunit;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public class FileNameServiceTests
    {
        [Fact]
        public void YearUpdateValidString()
        {
            FileNameService service = new FileNameService();
            var returns = service.YearUpdate("1920");
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
            FileNameService fileNameService = new FileNameService();
            Action a = () => fileNameService.YearUpdate(s);
            a.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void SerialNumberUpdateValidInput()
        {
            var sut = NewService();
            string result = sut.SerialNumberUpdate("01");
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
            var sut = NewService();
            Action a = () => sut.SerialNumberUpdate(number);
            a.Should().Throw<ArgumentException>();
        }


        [Fact]
        public void DateUpdateValidDate()
        {
            var sut = NewService();
            string result = sut.DateStampUpdate("20190101");
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
            var sut = NewService();
            Action result = () => sut.DateStampUpdate(date);
            result.Should().Throw<ArgumentException>();
        }

        [Fact]
        public void NameGenerationValidInput()
        {
            var sut = NewService();
            string result = sut.NameGeneration("ILR-10006341-1920-20190210-120000-01");
            result.Should().Be("ILR-10006341-2021-20190210-120000-01");

        }

        [Theory]
        [InlineData("120000", "120001")]
        [InlineData("235959", "000000")]
        public void TimeStampUpdateValidInput(string input, string expected)
        {
            var sut = NewService();
            string result = sut.TimeStampUpdate(input);
            result.Should().Be(expected);
        }

        [Theory]
        [InlineData("")]
        [InlineData(null)]
        [InlineData("1200000")]
        [InlineData("12000")]
        public void TimeStampUpdateInvalidInput(string date)
        {
            var sut = NewService();
            Action result = () => sut.TimeStampUpdate(date);
            result.Should().Throw<ArgumentException>();
        }

        private FileNameService NewService()
        {
            return new FileNameService();
        }
    }
}
