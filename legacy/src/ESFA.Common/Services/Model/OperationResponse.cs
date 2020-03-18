using System;
using ESFA.Common.Set;

namespace ESFA.Common.Model
{
    /// <summary>
    /// an operation response used in the operations manager
    /// </summary>
    internal class OperationResponse : IOperationResponse
    {
        /// <summary>
        /// Gets the result.
        /// </summary>
        public TypeOfOperationResult Result { get; set; }

        /// <summary>
        /// Gets the message.
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// Gets the exception.
        /// </summary>
        public Exception Exception { get; set; }

        public bool IsSuccess()
        {
            return Result == TypeOfOperationResult.Success;
        }
    }

    /// <summary>
    /// the response with a payload
    /// </summary>
    /// <typeparam name="T"></typeparam>
    internal sealed class OperationResponse<T> : OperationResponse, IOperationResponse<T>
    {
        /// <summary>
        /// Gets the payload.
        /// </summary>
        public T Payload { get; set; }
    }
}
