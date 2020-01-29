using System;
using System.Runtime.CompilerServices;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class TempLogger : ILogger
    {
        /*
         * Temp placeholder until the desktop logging nuget sis available.
         */

        public void Dispose()
        {
        }

        public void LogDebug(string message, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
        }

        public void LogError(string message, Exception exception = null, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
        }

        public void LogFatal(string message, Exception exception = null, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Fatal - " + message + Environment.NewLine + exception.Message);
            Console.ResetColor();
        }

        public void LogInfo(string message, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
            Console.WriteLine("Info - " + message);
        }

        public void LogVerbose(string message, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
            Console.WriteLine("Verbose - " + message);
        }

        public void LogWarning(string message, object[] parameters = null, long jobIdOverride = -1, [CallerMemberName] string callerMemberName = "", [CallerFilePath] string callerFilePath = "", [CallerLineNumber] int callerLineNumber = 0)
        {
        }
    }
}
