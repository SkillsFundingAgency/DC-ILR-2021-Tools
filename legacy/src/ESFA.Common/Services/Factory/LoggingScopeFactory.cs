using ESFA.Common.Manager;
using ESFA.Common.Model;
using System.Composition;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// the logging scope factory
    /// logging scopes should be used sparingly. 
    /// DO NOT nest them...
    /// </summary>
    /// <seealso cref="ICreateScopedLogging" />
    [Shared]
    [Export(typeof(ICreateScopedLogging))]
    public sealed class LoggingScopeFactory :
        ICreateScopedLogging
    {
        /// <summary>
        /// The log file path
        /// </summary>
        private string _logFilePath;

        /// <summary>
        /// Gets or sets the mediator.
        /// this property will require the composition import decorator
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the file (manager).
        /// </summary>
        [Import]
        public IManageTextFiles File { get; set; }

        /// <summary>
        /// Gets or sets the message (factory).
        /// </summary>
        [Import]
        public ICreateConsoleMessages Message { get; set; }

        /// <summary>
        /// begins the logging scope.
        /// </summary>
        /// <param name="storeIn">The store in.</param>
        /// <param name="initialisePath">if set to <c>true</c> [initialise path].</param>
        /// <returns>
        /// the currently running  task with the logging scope in it
        /// </returns>
        public ILoggingScope BeginScope(string storeIn, bool initialisePath)
        {
            if (initialisePath)
            {
                _logFilePath = File.CreateOperatingFolder("Easy OPA Log Files").Result;
            }

            return new LoggingScope(File, Mediator, Message, storeIn, _logFilePath);
        }
    }
}