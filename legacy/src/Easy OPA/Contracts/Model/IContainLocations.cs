namespace EasyOPA.Model
{
    /// <summary>
    /// i contain locations
    /// </summary>
    public interface IContainLocations
    {
        /// <summary>
        /// Gets the production location
        /// </summary>
        string Production { get; }

        /// <summary>
        /// Gets the experimental location
        /// </summary>
        string Experimental { get; }
    }
}
