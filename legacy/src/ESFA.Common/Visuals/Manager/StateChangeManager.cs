using ESFA.Common.Factory;
using ESFA.Common.Model;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.Diagnostics;
using System.Linq;
using System.Windows;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// the application state manager
    /// </summary>
    /// <seealso cref="IManageApplicationState" />
    [Shared]
    [Export(typeof(IManageApplicationState))]
    public sealed class StateChangeManager :
        IManageApplicationState
    {
        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the console message (factory)
        /// </summary>
        [Import]
        public ICreateApplicationStateMessages StateMessage { get; set; }

        /// <summary>
        /// busy scope
        /// </summary>
        /// <returns>
        /// returns an i disposable busy state scope
        /// </returns>
        public IScopeBusyState BusyScope(BusyState returnState)
        {
            IsAlreadyRunning
                .AsGuard<OperationCanceledException, CommonLocalised>(CommonLocalised.OnlyOneRunningCopyAllowed);

            return new BusyStateScope(Mediator, StateMessage, returnState);
        }

        /// <summary>
        /// Gets a value indicating whether this instance is already running.
        /// </summary>
        public bool IsAlreadyRunning =>
            Process.GetProcesses().Count(p => p.MainWindowTitle == Application.Current.MainWindow.Title) > 1;
    }
}