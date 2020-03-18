namespace EasyOPA.Model
{
    /// <summary>
    /// the (learning) providers (address) details
    /// </summary>
    /// <seealso cref="IProviderDetails" />
    public sealed class ProviderDetails :
    IProviderDetails
    {
        /// <summary>
        /// Gets the UKPRN.
        /// </summary>
        public long UKPRN { get; set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets the location.
        /// </summary>
        public string Location { get; set; }

        /// <summary>
        /// Gets the street.
        /// </summary>
        public string Street { get; set; }

        /// <summary>
        /// Gets the town.
        /// </summary>
        public string Town { get; set; }

        /// <summary>
        /// Gets the postcode.
        /// </summary>
        public string Postcode { get; set; }
    }
}
