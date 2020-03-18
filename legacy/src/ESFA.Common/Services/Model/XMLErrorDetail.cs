namespace ESFA.Common.Model
{
    /// <summary>
    /// the error detail (message and count)
    /// used in XML file validation
    /// </summary>
    internal sealed class XMLErrorDetail : 
        IDetailXmlValidationError
    {
        /// <summary>
        /// Gets or sets the message.
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// Gets or sets the count.
        /// </summary>
        public int Count { get; set; }

        /// <summary>
        /// Increases the count.
        /// </summary>
        public void IncreaseCount()
        {
            Count++;
        }
    }
}
