namespace EasyOPA.Model
{
    /// <summary>
    /// the input source learning provider details
    /// </summary>
    /// <seealso cref="ILearningProvider" />
    public sealed class LearningProvider :
        ILearningProvider
    {
        /// <summary>
        /// Gets or sets the identifier.
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// Gets or sets the learner count.
        /// </summary>
        public int LearnerCount { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected for processing.
        /// </summary>
        public bool IsSelectedForProcessing { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is enabled for selection.
        /// </summary>
        public bool IsEnabledForSelection { get; set; } = true;
    }
}
