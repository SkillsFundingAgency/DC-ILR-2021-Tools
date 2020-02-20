using ESFA.Common.Model;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// i create scoped logging
    /// </summary>
    public interface ICreateScopedLogging
    {
        /// <summary>
        /// begins the logging scope.
        /// </summary>
        /// <param name="storeIn">The store in.</param>
        /// <param name="initialisePath">if set to <c>true</c> [initialise path].</param>
        /// <returns>the currently running  task with the logging scope in it</returns>
        ILoggingScope BeginScope(string storeIn, bool initialisePath);
    }
}
