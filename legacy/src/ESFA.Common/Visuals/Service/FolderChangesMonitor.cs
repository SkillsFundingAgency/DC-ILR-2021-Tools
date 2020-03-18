using ESFA.Common.Model;
using ESFA.Common.Utility;
using System.Composition;
using System.IO;
using System.Linq;
using System.Threading;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the progress monitor
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IMonitorFolderchanges" />
    /// <seealso cref="Tiny.Framework.Contracts.Message.IHandleMessage{ICarryMonitorRequestMessage}" />
    /// <seealso cref="Tiny.Framework.Contracts.Message.IHandleMessage{ICarryCeaseMonitoringMessage}" />
    [Shared]
    [Export(typeof(IMonitorFolderchanges))]
    public sealed class FolderChangesMonitor :
        ObservableBase,
        IMonitorFolderchanges,
        IHandleMessage<ICarryMonitorRequestMessage>,
        IHandleMessage<ICarryCeaseMonitoringMessage>
    {
        /// <summary>
        /// The lock state
        /// </summary>
        private int _lockState;

        /// <summary>
        /// The watcher
        /// </summary>
        private FileSystemWatcher _watcher;

        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// show details
        /// </summary>
        private bool _showDetails;

        /// <summary>
        /// Gets or sets a value indicating whether [show details].
        /// </summary>
        public bool ShowDetails
        {
            get { return _showDetails; }
            set { SetPropertyValue(ref _showDetails, value); }
        }

        /// <summary>
        /// The (monitor) count
        /// </summary>
        private int _count;

        /// <summary>
        /// Gets or sets the (monitor) count.
        /// </summary>
        public int Count
        {
            get { return _count; }
            set { SetPropertyValue(ref _count, value); }
        }

        [OnImportsSatisfied]
        public void Compose()
        {
            RegisterMessageHandler();
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryMonitorRequestMessage message)
        {
            var watchPath = message.Payload.MonitorPath;
            var fileType = message.Payload.TargetType;

            StartWatcher(watchPath, fileType);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryCeaseMonitoringMessage message)
        {
            StopWatcher();
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public void RegisterMessageHandler()
        {
            Mediator.Register<ICarryMonitorRequestMessage>(HandleMessage, true);
            Mediator.Register<ICarryCeaseMonitoringMessage>(HandleMessage, true);
        }

        /// <summary>
        /// Stops the watcher.
        /// </summary>
        public void StopWatcher()
        {
            ShowDetails = false;
            _watcher.EnableRaisingEvents = false;
            _watcher.Dispose();
        }

        /// <summary>
        /// Starts the watcher.
        /// </summary>
        /// <param name="forWatchPath">For watch path.</param>
        /// <param name="andFileType">and file type</param>
        public void StartWatcher(string forWatchPath, string andFileType)
        {
            if (It.Has(_watcher) && _watcher.Path.ComparesWith(forWatchPath) && _watcher.Filter.ComparesWith(andFileType))
            {
                ShowDetails = true;
                _watcher.EnableRaisingEvents = true;

                return;
            }

            _watcher?.Dispose();

            ShowDetails = true;
            Count = 0;

            _watcher = new FileSystemWatcher();
            _watcher.Path = forWatchPath;
            _watcher.Filter = $"*.{andFileType}";
            _watcher.Created += MonitoredNotifyChange;
            _watcher.EnableRaisingEvents = true;
        }

        /// <summary>
        /// Monitor and notify change.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="FileSystemEventArgs"/> instance containing the event data.</param>
        private void MonitoredNotifyChange(object sender, FileSystemEventArgs e)
        {
            if (Interlocked.Increment(ref _lockState) == 1)
            {
                var folder = Path.GetDirectoryName(e.FullPath);
                var files = Directory.EnumerateFiles(folder);

                Count = files.Count();

                Interlocked.Decrement(ref _lockState);
            }
        }
    }
}
