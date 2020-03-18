using System;

namespace EasyOPA.Model
{
    /// <summary>
    /// the learning provider contract
    /// </summary>
    public interface ILearningProvider :
        ICanBeSelectedForProcessing
    {
        /// <summary>
        /// Gets the identifier.
        /// </summary>
        int ID { get; }

        /// <summary>
        /// Gets or sets the learner count.
        /// </summary>
        int LearnerCount { get; set; }
    }
}
