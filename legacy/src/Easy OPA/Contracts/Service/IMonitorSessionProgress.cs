namespace EasyOPA.Service
{
    /// <summary>
    /// i monitor session progress
    /// </summary>
    public interface IMonitorSessionProgress
    {
        /// <summary>
        /// Sets the position.
        /// </summary>
        /// <param name="newCount">The new count.</param>
        void SetProviderCount(int newCount);

        /// <summary>
        /// Increments the position.
        /// </summary>
        void IncrementPosition();

        /// <summary>
        /// Gets the session position.
        /// </summary>
        int ProviderPosition { get; }

        /// <summary>
        /// Sets the learner counts.
        /// </summary>
        /// <param name="invalid">The invalid.</param>
        /// <param name="total">The total.</param>
        /// <param name="valid">The valid.</param>
        void SetLearnerCounts(int invalid, int total, int valid);

        /// <summary>
        /// Sets the case count.
        /// </summary>
        /// <param name="shortName">The short name.</param>
        /// <param name="count">The count.</param>
        void SetCaseCount(string shortName, int count);
    }
}
