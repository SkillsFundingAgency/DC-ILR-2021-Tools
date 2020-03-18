using ESFA.Common.Set;
using ESFA.Common.Model;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Service
{
    /// <summary>
    /// a safe operation response handler
    /// </summary>
    /// <seealso cref="IHandleSafeOperationResponses" />
    [Shared]
    [Export(typeof(IHandleSafeOperationResponses))]
    public sealed class SafeOperationResponseHandler :
        IHandleSafeOperationResponses
    {
        /// <summary>
        /// Gets or sets the operation manager, which protects us from unanticipated errors
        /// </summary>
        [Import]
        public IConductSafeOperations OperationManager { get; set; }

        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Creates the message.
        /// </summary>
        /// <param name="lastState">if set to <c>true</c> [last state].</param>
        /// <returns>a last operation state message</returns>
        public ICarryLastOperationState CreateMessage(IOperationResponse lastState)
        {
            return new OperationStateMessage { Payload = lastState };
        }

        /// <summary>
        /// Processes the response.
        /// </summary>
        /// <param name="response">The response.</param>
        public void ProcessResponse<TLocalised>(IOperationResponse response)
            where TLocalised : struct, IComparable, IFormattable
        {
            if (!response.IsSuccess()
                && !ProcessError<CommonLocalised>(response)
                && !ProcessError<TLocalised>(response))
            {
                //Emitter.Publish(response.Exception.StackTrace);
                //Emitter.Publish(response.Exception.Message);

                Emitter.Publish(response.Message);
            }
        }

        public bool ProcessError<TLocalised>(IOperationResponse response)
            where TLocalised : struct, IComparable, IFormattable
        {
            if (FromSet<TLocalised>.GetNames().Any(x => Format.ComparesWith(x, response.Message)))
            {
                var candidate = FromSet<TLocalised>.Get(response.Message);
                Emitter.Publish(candidate);

                return true;
            }

            return false;
        }

        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <param name="thisOperation">this operation</param>
        public async Task RunOperation<TLocalised>(Action thisOperation)
            where TLocalised : struct, IComparable, IFormattable
        {
            await Task.Run(() =>
            {
                var response = OperationManager.RunSafe(thisOperation);
                ProcessResponse<TLocalised>(response);
                Mediator.Publish(CreateMessage(response));
            });
        }

        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <param name="thisOperation">this operation</param>
        /// <returns>
        /// the running task
        /// </returns>
        public async Task RunAsyncOperation<TLocalised>(Func<Task> thisOperation)
            where TLocalised : struct, IComparable, IFormattable
        {
            var response = await OperationManager.RunSafeAsync(thisOperation);
            ProcessResponse<TLocalised>(response);
            Mediator.Publish(CreateMessage(response));
        }

        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <typeparam name="TPayload">The type of returning payload.</typeparam>
        /// <param name="thisOperation">The this operation.</param>
        /// <returns>
        /// the running payload task
        /// </returns>
        public async Task<TPayload> RunAsyncOperation<TPayload, TLocalised>(Func<Task<TPayload>> thisOperation)
            where TLocalised : struct, IComparable, IFormattable
        {
            var response = await OperationManager.RunSafeAsync(thisOperation);
            ProcessResponse<TLocalised>(response);
            Mediator.Publish(CreateMessage(response));

            return response.Payload;
        }
    }
}