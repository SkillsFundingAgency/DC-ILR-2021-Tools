using ESFA.Common.Set;
using System;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the standard dal response 
    /// </summary>
    public interface IOperationResponse
    {
        /// <summary>
        /// Gets the result.
        /// </summary>
        TypeOfOperationResult Result { get; }

        /// <summary>
        /// Gets the exception.
        /// </summary>
        Exception Exception { get; }

        /// <summary>
        /// Gets the message.
        /// </summary>
        string Message { get; }

        /// <summary>
        /// Determines whether this instance is success.
        /// </summary>
        /// <returns>true if the operation succeeded</returns>
        bool IsSuccess();
    }

    /// <summary>
    /// the operations manager operational response (of type T)
    /// </summary>
    public interface IOperationResponse<T> : IOperationResponse
    {
        /// <summary>
        /// Gets the payload.
        /// </summary>
        T Payload { get; }
    }
}
