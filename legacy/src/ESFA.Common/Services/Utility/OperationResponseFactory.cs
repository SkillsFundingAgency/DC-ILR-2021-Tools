using ESFA.Common.Model;
using ESFA.Common.Set;
using System;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// the operation response factory
    /// this is only used in one place in the operation manager, so static is ok here...
    /// </summary>
    internal static class OperationResponseFactory
    {
        /// <summary>
        /// Creates an operation response.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="payload">The payload.</param>
        /// <param name="result">The result.</param>
        /// <returns>an operation response of type T</returns>
        internal static IOperationResponse<T> Create<T>(T payload, TypeOfOperationResult result = TypeOfOperationResult.Success)
        {
            return new OperationResponse<T> { Payload = payload, Result = result };
        }

        /// <summary>
        /// Creates an operation response.
        /// </summary>
        /// <returns>
        /// an operational success
        /// </returns>
        internal static IOperationResponse Create()
        {
            return new OperationResponse { Result = TypeOfOperationResult.Success };
        }

        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="result">The result.</param>
        /// <returns>
        /// an operational failure with a message
        /// </returns>
        internal static IOperationResponse Create(string message, TypeOfOperationResult result = TypeOfOperationResult.Failure)
        {
            return new OperationResponse { Result = result, Message = message };
        }

        /// <summary>
        /// Creates an operation response.
        /// </summary>
        /// <param name="error">The error.</param>
        /// <param name="result">The result.</param>
        /// <returns>
        /// an operational failure with a message
        /// </returns>
        internal static IOperationResponse Create(Exception error, TypeOfOperationResult result = TypeOfOperationResult.Failure)
        {
            return new OperationResponse { Result = result, Exception = error };
        }

        /// <summary>
        /// Creates an operation response.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message">The message.</param>
        /// <param name="result">The result.</param>
        /// <returns>
        /// an operational failure of type T
        /// </returns>
        internal static IOperationResponse<T> Create<T>(string message, TypeOfOperationResult result = TypeOfOperationResult.Failure)
        {
            return new OperationResponse<T> { Payload = default(T), Result = result, Message = message };
        }

        /// <summary>
        /// Creates an operation response.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="error">The error.</param>
        /// <param name="result">The result.</param>
        /// <returns>
        /// an operational failure of type T
        /// </returns>
        internal static IOperationResponse<T> Create<T>(Exception error, TypeOfOperationResult result = TypeOfOperationResult.Failure)
        {
            return new OperationResponse<T> { Payload = default(T), Result = result, Exception = error };
        }
    }
}
