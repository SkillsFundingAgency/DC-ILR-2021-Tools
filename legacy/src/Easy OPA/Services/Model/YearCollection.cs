using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// the year collection (configuration)
    /// </summary>
    /// <seealso cref="IYearCollection" />
    public sealed class YearCollection : 
        IYearCollection
    {
        /// <summary>
        /// Gets the year.
        /// </summary>
        public BatchOperatingYear Year { get; set; }

        /// <summary>
        /// Gets the collection.
        /// </summary>
        public TypeOfCollection Collection { get; set; }
    }
}
