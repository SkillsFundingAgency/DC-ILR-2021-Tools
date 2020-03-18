using ESFA.Common.Model;
using ESFA.Common.Utility;
using System;
using System.Composition;
using System.Threading.Tasks;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the operation response manager
    /// </summary>
    /// <seealso cref="IManageOperations" />
    [Shared, Export(typeof(IConductSafeOperations))]
    public sealed class OperationManager : 
        IConductSafeOperations
    {
        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <returns>
        /// returns an operational response
        /// </returns>
        public IOperationResponse RunSafe(Action action)
        {
            try
            {
                action();
                return OperationResponseFactory.Create();
            }

            catch (Exception e)
            {
                return OperationResponseFactory.Create(e.Message);
            }
        }

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="action">The action.</param>
        /// <returns>
        /// returns an operational response with a payload of type T
        /// </returns>
        public IOperationResponse<T> RunSafe<T>(Func<T> action)
        {
            try
            {
                return OperationResponseFactory.Create(action());
            }

            catch (Exception e)
            {
                return OperationResponseFactory.Create<T>(e.Message);
            }
        }

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <param name="action">The action.</param>
        /// <returns>
        /// returns an operational response
        /// </returns>
        public async Task<IOperationResponse> RunSafeAsync(Func<Task> action)
        {
            try
            {
                await action();
                return OperationResponseFactory.Create();
            }

            catch (Exception e)
            {
                return OperationResponseFactory.Create(e.Message);
            }
        }

        /// <summary>
        /// Runs the specified action safely.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="action">The action.</param>
        /// <returns>
        /// returns an operational response with a payload of type T
        /// </returns>
        public async Task<IOperationResponse<T>> RunSafeAsync<T>(Func<Task<T>> action)
        {
            try
            {
                var result = await action();
                return OperationResponseFactory.Create(result);
            }

            catch (Exception e)
            {
                return OperationResponseFactory.Create<T>(e.Message);
            }
        }
    }
}
