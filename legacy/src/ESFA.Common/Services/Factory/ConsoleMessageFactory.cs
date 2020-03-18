using ESFA.Common.Model;
using System.Composition;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// the console message factory
    /// </summary>
    /// <seealso cref="ICreateConsoleMessages" />
    [Shared]
    [Export(typeof(ICreateConsoleMessages))]
    public sealed class ConsoleMessageFactory : 
        ICreateConsoleMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns>
        /// a console message ready for transportation
        /// </returns>
        public ICarryConsoleMessage Create(string message)
        {
            return new ConsoleMessage { Payload = message };
        }

        /// <summary>
        /// Creates the logging scope notification message.
        /// </summary>
        /// <param name="startScope">if set to <c>true</c> [start scope].</param>
        /// <returns>
        /// a logging scope notification message
        /// </returns>
        public ICarryScopedLoggingNotificiationMessage Create(bool startScope)
        {
            return new ScopedLogginingNotificationMessage
            {
                Payload = startScope
            };
        }
    }
}
