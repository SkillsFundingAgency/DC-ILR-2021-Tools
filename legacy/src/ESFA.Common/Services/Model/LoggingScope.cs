using ESFA.Common.Factory;
using ESFA.Common.Manager;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// a scoped disposable logger
    /// </summary>
    /// <seealso cref="ILoggingScope" />
    /// <seealso cref="Tiny.Framework.Contracts.Message.IHandleMessage{ICarryConsoleMessage}" />
    internal sealed class LoggingScope :
        ILoggingScope,
        IHandleMessage<ICarryConsoleMessage>
    {
        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        public string Text { get; set; }

        /// <summary>
        /// is listening
        /// </summary>
        private long _isListening;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is listening.
        /// threadsafe operation
        /// </summary>
        public bool IsListening
        {
            get { return Interlocked.Read(ref _isListening) > 0; }
            set
            {
                var temp = value
                    ? Interlocked.Increment(ref _isListening)
                    : Interlocked.Decrement(ref _isListening);
            }
        }

        /// <summary>
        /// Gets the log file path.
        /// </summary>
        public string LogFilePath { get; }

        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        public string FileName { get; }

        /// <summary>
        /// Gets the mediator (event publication manager).
        /// </summary>
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets the file (manager).
        /// </summary>
        public IManageTextFiles File { get; }

        /// <summary>
        /// Gets the message (factory).
        /// </summary>
        public ICreateConsoleMessages Message { get; }

        public LoggingScope(
            IManageTextFiles fileManager,
            IManageEventPublication mediator,
            ICreateConsoleMessages factory,
            string fileName,
            string logFilePath)
        {
            File = fileManager;
            Mediator = mediator;
            Message = factory;

            FileName = fileName;
            LogFilePath = logFilePath;

            Text = string.Empty;
            IsListening = true;

            RegisterMessageHandler();
        }

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources.
        /// </summary>
        public void Dispose()
        {
            IsListening = false;

            Mediator.Publish(Message.Create(false));

            Task.Run(async () =>
            {
                var logFileName = Path.Combine(LogFilePath, FileName);
                await File.Save(logFileName, Text);
            });
        }

        /// <summary>
        /// Adds a message.
        /// </summary>
        /// <param name="newMessage">The new message.</param>
        public void AddMessage(string newMessage)
        {
            Text += $"{newMessage}{Environment.NewLine}";
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryConsoleMessage message)
        {
            if (IsListening)
            {
                AddMessage(message.Payload);
            }
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public void RegisterMessageHandler()
        {
            Mediator.Register<ICarryConsoleMessage>(HandleMessage);
            Mediator.Publish(Message.Create(true));
        }
    }
}
