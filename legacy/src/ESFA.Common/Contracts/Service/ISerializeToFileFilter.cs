namespace ESFA.Common.Service
{
    /// <summary>
    /// i serialise to file filter
    /// </summary>
    public interface ISerializeToFileFilter
    {
        /// <summary>
        /// Gets the filter.
        /// </summary>
        /// <typeparam name="TFiltered">the filter type</typeparam>
        /// <returns>the filter string</returns>
        string GetFilter<TFiltered>() where TFiltered : class;
    }
}
