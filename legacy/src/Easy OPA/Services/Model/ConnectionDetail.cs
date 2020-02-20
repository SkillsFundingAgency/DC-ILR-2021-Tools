namespace EasyOPA.Model
{
    /// <summary>
    /// connection detail (container)
    /// </summary>
    /// <seealso cref="IConnectionDetail" />
    public sealed class ConnectionDetail :
        IConnectionDetail
    {
        /// <summary>
        /// Gets the name.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets the container.
        /// </summary>
        public string Container { get; set; }

        /// <summary>
        /// Gets the connection details.
        /// </summary>
        public string SQLDetail { get; set; }

        /// <summary>
        /// Gets the oledb/com detail.
        /// </summary>
        public string COMDetail { get; set; }
    }
}
