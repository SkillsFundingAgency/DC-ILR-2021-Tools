using System;
using System.Threading.Tasks;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// Run safe actions.
    /// </summary>
    public static class RunSafe
    {
        /// <summary>
        /// Try the specified action and handler.
        /// </summary>
        /// <param name="action">Action.</param>
        /// <param name="handler">Handler.</param>
        public static void Try(Action action, Action<Exception> handler = null)
        {
            try
            {
                action?.Invoke();
            }

            catch (Exception e)
            {
                handler?.Invoke(e);
            }
        }

        /// <summary>
        /// Try the specified action and handler.
        /// </summary>
        /// <returns>The try.</returns>
        /// <param name="action">Action.</param>
        /// <param name="handler">Handler.</param>
        public static async Task Try(Func<Task> action, Func<Exception, Task> handler = null)
        {
            try
            {
                await action?.Invoke();
            }

            catch (Exception e)
            {
                await handler?.Invoke(e);
            }
        }

        /// <summary>
        /// Tries the specified action.
        /// </summary>
        /// <typeparam name="TResult">The type of the result.</typeparam>
        /// <param name="action">The action.</param>
        /// <returns>the result of type TResult</returns>
        public static TResult Try<TResult>(Func<TResult> action, Action<Exception> handler = null)
        {
            try
            {
                return action.Invoke();
            }

            catch (Exception e)
            {
                handler?.Invoke(e);

                return default(TResult);
            }
        }

        /// <summary>
        /// Tries the specified action.
        /// </summary>
        /// <typeparam name="TResult">The type of the result.</typeparam>
        /// <param name="action">The action.</param>
        /// <param name="fallback">The fallback.</param>
        /// <returns>the result of type TResult</returns>
        public static TResult Try<TResult>(Func<TResult> action, Func<TResult> fallback)
        {
            try
            {
                return action.Invoke();
            }

            catch
            {
                return fallback.Invoke();
            }
        }

        /// <summary>
        /// Tries the specified action.
        /// </summary>
        /// <typeparam name="TResult">The type of the result.</typeparam>
        /// <param name="action">The action.</param>
        /// <returns>the result of type TResult</returns>
        public static async Task<TResult> Try<TResult>(Func<Task<TResult>> action, Func<Exception, Task> handler = null)
        {
            try
            {
                return await action?.Invoke();
            }

            catch (Exception e)
            {
                await handler?.Invoke(e);
                return await Task.FromResult(default(TResult));
            }
        }

    }
}
