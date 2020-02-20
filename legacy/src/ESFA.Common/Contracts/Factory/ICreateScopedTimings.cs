using ESFA.Common.Model;
using System;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// i create scoped logging
    /// </summary>
    public interface ICreateScopedTimings
    {
        /// <summary>
        /// begins the timing scope.
        /// </summary>
        /// <param name="timingPreamble">The timing (report) preamble.</param>
        /// <param name="doAverage">do average.</param>
        /// <returns>
        /// the currently running  task with the timing scope in it
        /// </returns>
        ITimingScope BeginScope(string timingPreamble, Func<TimeSpan, string> doAverage = null);
    }
}
