namespace ESFA.Common.Model
{
    /// <summary>
    /// i request monitor (this) path and file type
    /// </summary>
    /// <seealso cref="IRequestPathMonitoring" />
    public sealed class MonitorPathRequest :
        IRequestPathMonitoring
    {
        /// <summary>
        /// Gets the monitoring path.
        /// </summary>
        public string MonitorPath { get; set; }

        /// <summary>
        /// Gets the target type.
        /// </summary>
        public string TargetType { get; set; }
    }
}
