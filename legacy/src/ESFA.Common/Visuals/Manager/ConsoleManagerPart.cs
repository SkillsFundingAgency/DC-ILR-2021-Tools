using ESFA.Common.Model;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.Threading;
using System.Threading.Tasks;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// the console component, a log listener
    /// there will only be one of these on the screen so shared is OK
    /// visual binding and 'observability' turns a class into a 'component'
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IManageConsoleOutput" />
    /// <seealso cref="IHandleMessage{IConsoleMessage}" />
    [Shared]
    [Export(typeof(IManageConsoleOutput))]
    public sealed class ConsoleManagerPart :
        ObservableBase,
        IManageConsoleOutput,
        IHandleMessage<ICarryConsoleMessage>,
        IHandleMessage<ICarryScopedLoggingNotificiationMessage>
    {
        /// <summary>
        /// Gets or sets the mediator.
        /// this property will require the composition import decorator
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the (safe operation response) handler.
        /// </summary>
        [Import]
        public IHandleSafeOperationResponses Handler { get; set; }

        /// <summary>
        /// Gets or sets the file (manager).
        /// </summary>
        [Import]
        public IManageTextFiles File { get; set; }

        /// <summary>
        /// The last line
        /// </summary>
        private string _lastLine;

        /// <summary>
        /// Gets or sets the last line.
        /// </summary>
        public string LastLine
        {
            get { return _lastLine; }
            set { SetPropertyValue(ref _lastLine, value); }
        }

        /// <summary>
        /// The text
        /// </summary>
        private string _text;

        /// <summary>
        /// Gets or sets the console text.
        /// </summary>
        public string Text
        {
            get { return _text; }
            set { SetPropertyValue(ref _text, value); }
        }

        /// <summary>
        /// The scoped logging
        /// </summary>
        private long _scopedLogging;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is scoped logging.
        /// thread safe, as scopes will be built across differing threads.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is scoped logging; otherwise, <c>false</c>.
        /// </value>
        public bool IsScopedLogging
        {
            get { return Interlocked.Read(ref _scopedLogging) > 0; }
            set
            {
                var temp = value
                    ? Interlocked.Increment(ref _scopedLogging)
                    : Interlocked.Decrement(ref _scopedLogging);
            }
        }

        /// <summary>
        /// Adds a message.
        /// </summary>
        /// <param name="newMessage">The new message.</param>
        public void AddMessage(string newMessage)
        {
            var isHeadline = IsHeadline(newMessage);

            if (!IsScopedLogging || isHeadline)
            {
                Text += $"{newMessage}{Environment.NewLine}";
            }

            // review: shonky
            if (isHeadline && !newMessage.Contains("========="))
            {
                LastLine = newMessage;
            }
        }

        /// <summary>
        /// Determines whether the specified candidate is (a) headline.
        /// </summary>
        /// <param name="candidate">The candidate.</param>
        /// <returns>
        ///   <c>true</c> if the specified candidate is headline; otherwise, <c>false</c>.
        /// </returns>
        public bool IsHeadline(string candidate) => !candidate.StartsWith("\t");

        /// <summary>
        /// Clears the console.
        /// </summary>
        public void Clear()
        {
            Text = string.Empty;
        }

        /// <summary>
        /// Saves the output to the specified file.
        /// </summary>
        /// <param name="getFileName">gets the name of the file.</param>
        /// <returns>the running task</returns>
        public async Task Save(Func<string> getFileName)
        {
            await Handler.RunAsyncOperation<CommonLocalised>(async () =>
            {

                var fileName = getFileName();

                It.IsEmpty(fileName)
                    .AsGuard<OperationCanceledException, CommonLocalised>(CommonLocalised.CanceledOperation);

                await File.Save(fileName, Text);
            });
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryConsoleMessage message)
        {
            AddMessage(message.Payload);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryScopedLoggingNotificiationMessage message)
        {
            IsScopedLogging = message.Payload;
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        [OnImportsSatisfied]
        public void RegisterMessageHandler()
        {
            Mediator.Register<ICarryConsoleMessage>(HandleMessage);
            Mediator.Register<ICarryScopedLoggingNotificiationMessage>(HandleMessage);
        }
    }
}
