using System;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// Contains methods to guard against invalid input
    /// </summary>
    public static class Guard
    {
        /// <summary>
        /// As guard.
        /// </summary>
        /// <typeparam name="TExceptionType">The type of exception</typeparam>
        /// <param name="failedEvaluation">if set to <c>true</c> [failed evaluation].</param>
        /// <param name="source">The source.</param>
        public static void AsGuard<TExceptionType, TLocalised>(this bool failedEvaluation, TLocalised source)
            where TExceptionType : Exception
            where TLocalised : struct, IComparable, IFormattable

        {
            if (failedEvaluation)
            {
                throw GetException<TExceptionType>($"{source}");
            }
        }

        /// <summary>
        /// Gets the exception.
        /// </summary>
        /// <typeparam name="TExceptionType">The type of exception</typeparam>
        /// <param name="args">The arguments.</param>
        /// <returns>an Exception of the prescribed type</returns>
        private static Exception GetException<TExceptionType>(params object[] args)
            where TExceptionType : Exception
        {
            return (Exception)Activator.CreateInstance(typeof(TExceptionType), args);
        }
    }
}
