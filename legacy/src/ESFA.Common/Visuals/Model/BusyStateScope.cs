using ESFA.Common.Factory;
using ESFA.Common.Set;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the application busy state scope
    /// </summary>
    /// <seealso cref="IBusyStateScope" />
    internal sealed class BusyStateScope : IScopeBusyState
    {
        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        public IManageEventPublication Mediator { get; }

        /// <summary>
        /// Gets or sets the console message (factory)
        /// </summary>
        public ICreateApplicationStateMessages StateMessage { get; }

        public BusyState ReturnState { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="BusyStateScope"/> class.
        /// </summary>
        /// <param name="mediator">The mediator.</param>
        /// <param name="stateMessage">The state message.</param>
        public BusyStateScope(IManageEventPublication mediator, ICreateApplicationStateMessages stateMessage, BusyState returnState = BusyState.IsIdle)
        {
            Mediator = mediator;
            StateMessage = stateMessage;
            ReturnState = returnState;

            Mediator.Publish(StateMessage.Create(BusyState.IsBusy));
        }

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources.
        /// </summary>
        public void Dispose()
        {
            Mediator.Publish(StateMessage.Create(ReturnState));
        }
    }
}
