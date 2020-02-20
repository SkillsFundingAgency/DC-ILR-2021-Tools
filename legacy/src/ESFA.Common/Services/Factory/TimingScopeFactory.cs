using ESFA.Common.Model;
using ESFA.Common.Service;
using System;
using System.Composition;

namespace ESFA.Common.Factory
{
    [Shared]
    [Export(typeof(ICreateScopedTimings))]
    public sealed class TimingScopeFactory :
        ICreateScopedTimings
    {
        /// <summary>
        /// Gets or sets the mediator.
        /// this property will require the composition import decorator
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// begins the timing scope.
        /// </summary>
        /// <param name="timingPreamble">The timing (report) preamble.</param>
        /// <param name="doAverage">do average.</param>
        /// <returns>
        /// the currently running  task with the timing scope in it
        /// </returns>
        public ITimingScope BeginScope(string timingPreamble, Func<TimeSpan, string> doAverage)
        {
            return new TimingScope(Emitter, timingPreamble, doAverage);
        }
    }
}