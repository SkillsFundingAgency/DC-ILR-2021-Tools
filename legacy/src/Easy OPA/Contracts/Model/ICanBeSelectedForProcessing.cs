namespace EasyOPA.Model
{
    /// <summary>
    /// i can be selected for processing
    /// </summary>
    public interface ICanBeSelectedForProcessing
    {
        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected for processing.
        /// </summary>
        bool IsSelectedForProcessing { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is enabled for selection.
        /// </summary>
        bool IsEnabledForSelection { get; set; }
    }
}
