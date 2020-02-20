using System;
using ESFA.Common.Model;
using System.Threading.Tasks;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i manage operations
    /// </summary>
    public interface IConductSafeOperations
    {
        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <returns>returns an operational response</returns>
        IOperationResponse RunSafe(Action action);

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="action">The action.</param>
        /// <returns>returns an operational response with a payload of type T</returns>
        IOperationResponse<T> RunSafe<T>(Func<T> action);

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <returns>returns an operational response</returns>
        Task<IOperationResponse> RunSafeAsync(Func<Task> action);

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="action">The action.</param>
        /// <returns>
        /// returns an operational response with a payload of type T
        /// </returns>
        Task<IOperationResponse<T>> RunSafeAsync<T>(Func<Task<T>> action);
    }
}
