using ESFA.Common.Composition;
using ESFA.Common.Manager;
using ESFA.Common.Model;
using ESFA.Common.Service;
using ESFA.Common.Set;
using ESFA.Common.Utility;
using System.Collections.Generic;
using System.Composition;
using System.Diagnostics;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Abstract
{
    /// <summary>
    /// an abstract state view model base
    /// 
    /// this view model also contains an number of functional injection requirements:
    ///     the console (log) emitter
    ///     the application state manager
    ///     the safe operation and response manager
    ///     the relay command factory
    ///     the mediator (event registrar and publisher)
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IHandleMessage{IChangeStateMessage}" />
    public abstract class StateViewModelBase :
        ObservableBase,
        IHandleMessage<ICarryChangeStateMessage>,
        IHandleMessage<ICarryLastOperationState>
    {
        private Stack<int> _interactionStack = new Stack<int>();

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the application state manager.
        /// </summary>
        [Import]
        public IManageApplicationState State { get; set; }

        /// <summary>
        /// Gets or sets the command factory.
        /// this is a button binding mechanism
        /// </summary>
        [Import]
        public ICreateRelayCommands CommandFactory { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// this property will require the composition import decorator
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the request help command.
        /// </summary>
        public IRelayCommand RequestHelpCommand { get; set; }

        /// <summary>
        /// Gets or sets the follow link command.
        /// </summary>
        public IRelayCommand FollowLinkCommand { get; set; }

        /// <summary>
        /// Gets or sets the reset state command.
        /// </summary>
        public IRelayCommand ResetStateCommand { get; set; }

        /// <summary>
        /// The last operation completed, default to true...
        /// </summary>
        private bool _lastOperationCompleted = true;

        /// <summary>
        /// Gets or sets a value indicating whether [last operation completed].
        /// </summary>
        public bool LastOperationCompleted
        {
            get { return _lastOperationCompleted; }
            set { SetPropertyValue(ref _lastOperationCompleted, value); }
        }

        /// <summary>
        /// The interaction state
        /// </summary>
        private int _interactionState;

        /// <summary>
        /// Gets or sets the state of the interaction.
        /// </summary>
        public int CurrentState
        {
            get { return _interactionState; }
            set { SetPropertyValue(ref _interactionState, value); }
        }

        /// <summary>
        /// Called when [property changed].
        /// </summary>
        /// <param name="propertyName">Name of the property.</param>
        protected override void OnPropertyChanged(string propertyName)
        {
            base.OnPropertyChanged(propertyName);

            if (propertyName.ComparesWith(nameof(CurrentState)))
            {
                // reset the last operation state as we've moved on
                if (CurrentState == InteractionState.IsBusy)
                {
                    LastOperationCompleted = true;
                }

                OnStateChanged();
            }
        }

        [OnImportsSatisfied]
        public virtual void OnCompositionComplete()
        {
            RequestHelpCommand = CommandFactory.Create(RequestHelp, () => true);
            FollowLinkCommand = CommandFactory.Create<string>(FollowLink, () => true);
            ResetStateCommand = CommandFactory.Create(ResetState, () => true);

            RegisterMessageHandler();
        }

        /// <summary>
        /// Requests the presence of the help popup.
        /// </summary>
        public void RequestHelp()
        {
            CurrentState = InteractionState.IsModalRequestHelp;
        }

        /// <summary>
        /// Follows the link (through to the external source)
        /// </summary>
        /// <param name="thisLink">this link.</param>
        public void FollowLink(string thisLink)
        {
            Process.Start(thisLink);
        }

        /// <summary>
        /// Resets the (interaction) state.
        /// </summary>
        public void ResetState()
        {
            _interactionStack.Clear();
            CurrentState = InteractionState.Idle;
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public virtual void RegisterMessageHandler()
        {
            Mediator.Register<ICarryChangeStateMessage>(HandleMessage, true);
            Mediator.Register<ICarryLastOperationState>(HandleMessage, true);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryChangeStateMessage message)
        {
            var stateChange = message.Payload;
            if (stateChange == BusyState.IsBusy)
            {
                _interactionStack.Push(CurrentState);
                CurrentState = InteractionState.IsBusy;
                return;
            }

            if (stateChange == BusyState.ClearState)
            {
                _interactionStack.Clear();
                CurrentState = InteractionState.Idle;
                return;
            }

            if (It.HasValues(_interactionStack))
            {
                var lastState = _interactionStack.Pop();
                CurrentState = lastState;
            }
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ICarryLastOperationState message)
        {
            LastOperationCompleted = message.Payload.IsSuccess();
            if (!LastOperationCompleted)
            {
                _interactionStack.Clear();
                CurrentState = InteractionState.Idle;
            }
        }

        /// <summary>
        /// Called when [state changed].
        /// </summary>
        protected abstract void OnStateChanged();
    }
}
