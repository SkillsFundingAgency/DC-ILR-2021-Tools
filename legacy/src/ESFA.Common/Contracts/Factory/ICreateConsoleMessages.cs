using ESFA.Common.Model;

namespace ESFA.Common.Factory
{
    /// <summary>
    ///  i create console messages
    /// </summary>
    public interface ICreateConsoleMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns>a console message ready for transportation</returns>
        ICarryConsoleMessage Create(string message);

        /// <summary>
        /// Creates the logging scope notification message.
        /// </summary>
        /// <param name="startScope">if set to <c>true</c> [start scope].</param>
        /// <returns>a logging scope notification message</returns>
        ICarryScopedLoggingNotificiationMessage Create(bool startScope);
    }
}
