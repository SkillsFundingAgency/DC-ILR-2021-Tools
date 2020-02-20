using System;
using System.Threading.Tasks;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i handle safe operation responses
    /// </summary>
    public interface IHandleSafeOperationResponses
    {
        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <typeparam name="TLocalised">localised (error keys).</typeparam>
        /// <param name="thisOperation">this operation</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        Task RunOperation<TLocalised>(Action thisOperation)
            where TLocalised : struct, IComparable, IFormattable;

        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <typeparam name="TLocalised">localised (error keys).</typeparam>
        /// <param name="thisOperation">this operation</param>
        /// <returns>
        /// the running task
        /// </returns>
        Task RunAsyncOperation<TLocalised>(Func<Task> thisOperation)
            where TLocalised : struct, IComparable, IFormattable;

        /// <summary>
        /// Runs the operation (and handles the response if the operation fails)
        /// </summary>
        /// <typeparam name="TPayload">The type of returning payload.</typeparam>
        /// <typeparam name="TLocalised">localised (error keys).</typeparam>
        /// <param name="thisOperation">The this operation.</param>
        /// <returns>
        /// the running payload task
        /// </returns>
        Task<TPayload> RunAsyncOperation<TPayload, TLocalised>(Func<Task<TPayload>> thisOperation)
            where TLocalised : struct, IComparable, IFormattable;
    }
}
