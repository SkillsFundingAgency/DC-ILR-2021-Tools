using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// the year collection (configuration message payload)
    /// </summary>
    public interface IYearCollection
    {
        /// <summary>
        /// Gets the year.
        /// </summary>
        BatchOperatingYear Year { get; }

        /// <summary>
        /// Gets the collection.
        /// </summary>
        TypeOfCollection Collection { get; }
    }
}
