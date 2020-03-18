namespace EasyOPA.Model
{
    /// <summary>
    /// i provider details, the organisations address info
    /// </summary>
    public interface IProviderDetails
    {
        /// <summary>
        /// Gets the UKPRN.
        /// </summary>
        long UKPRN { get; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        string Name { get; }

        /// <summary>
        /// Gets the location.
        /// </summary>
        string Location { get; }

        /// <summary>
        /// Gets the street.
        /// </summary>
        string Street { get; }

        /// <summary>
        /// Gets the town.
        /// </summary>
        string Town { get; }

        /// <summary>
        /// Gets the postcode.
        /// </summary>
        string Postcode { get; }
    }
}
