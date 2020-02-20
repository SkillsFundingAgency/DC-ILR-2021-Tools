namespace ESFA.Common.Model
{
    /// <summary>
    /// i request path monitoring
    /// </summary>
    public interface IRequestPathMonitoring
    {
        /// <summary>
        /// Gets the monitoring path.
        /// </summary>
        string MonitorPath { get; }

        /// <summary>
        /// Gets the target type.
        /// </summary>
        string TargetType { get; }
    }
}
