using ESFA.Common.Service;
using ESFA.Common.Set;
using System;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Model
{
    /// <summary>
    /// a scoped disposable timer
    /// </summary>
    /// <seealso cref="ITimingScope" />
    internal sealed class TimingScope :
        ITimingScope
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        public IEmitToConsole Emitter { get; }

        /// <summary>
        /// Gets the preamble.
        /// </summary>
        public string Preamble { get; }

        /// <summary>
        /// Does the average.
        /// </summary>
        public Func<TimeSpan, string> DoAverage { get; }

        /// <summary>
        /// Gets the start time.
        /// </summary>
        public DateTime StartTime { get; }

        public TimingScope(
            IEmitToConsole emitter,
            string preamble,
            Func<TimeSpan, string> doAverage)
        {
            Emitter = emitter;
            Preamble = preamble;
            DoAverage = doAverage;

            StartTime = DateTime.Now;
        }

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources.
        /// </summary>
        public void Dispose()
        {
            var endTime = DateTime.Now;

            var duration = endTime - StartTime;
            var msg = $"Started: {StartTime:HH:mm:ss.fff}, Finished: {endTime:HH:mm:ss.fff}{Environment.NewLine}{Preamble} ran for a total of: {duration:c}";
            Emitter.Publish(msg);

            if (It.Has(DoAverage))
            {
                Emitter.Publish(DoAverage?.Invoke(duration));
            }

            Emitter.Publish(CommonLocalised.LineDivider);
        }
    }
}
