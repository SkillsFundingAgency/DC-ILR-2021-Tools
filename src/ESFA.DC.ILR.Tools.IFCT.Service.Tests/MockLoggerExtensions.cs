using System;
using System.Linq.Expressions;
using ESFA.DC.Logging.Interfaces;
using Moq;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Tests
{
    public static class MockLoggerExtensions
    {
        private static bool CheckLog(Mock<ILogger> loggerMock, Expression<Action<ILogger>> expression, Times times)
        {
            if (loggerMock == null)
            {
                return false;
            }

            try
            {
                loggerMock.Verify(expression, times);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool VerifyInfo(this Mock<ILogger> loggerMock, string expectedLogString, Times times)
        {
            return expectedLogString == null ?
                CheckLog(loggerMock, v => v.LogInfo(It.IsAny<string>(), default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times)
                : CheckLog(loggerMock, v => v.LogInfo(expectedLogString, default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times);
        }

        public static bool VerifyVerbose(this Mock<ILogger> loggerMock, string expectedLogString, Times times)
        {
            return expectedLogString == null ?
                CheckLog(loggerMock, v => v.LogVerbose(It.IsAny<string>(), default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times)
                : CheckLog(loggerMock, v => v.LogVerbose(expectedLogString, default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times);
        }

        public static bool VerifyFatal(this Mock<ILogger> loggerMock, string expectedLogString, Times times)
        {
            return expectedLogString == null ?
                CheckLog(loggerMock, v => v.LogFatal(It.IsAny<string>(), It.IsAny<Exception>(), default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times)
                : CheckLog(loggerMock, v => v.LogFatal(expectedLogString, It.IsAny<Exception>(), default(object[]), It.IsAny<long>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<int>()), times);
        }
    }
}
