namespace ESFA.Common.Model
{
    /// <summary>
    /// i detail xml validation errors
    /// </summary>
    public interface IDetailXmlValidationError
    {
        /// <summary>
        /// Gets the message.
        /// </summary>
        string Message { get; }

        /// <summary>
        /// Gets the count.
        /// </summary>
        int Count { get; }

        /// <summary>
        /// Increases the count.
        /// </summary>
        void IncreaseCount();
    }
}
