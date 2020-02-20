using EasyOPA.Model;
using System.Threading.Tasks;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide bulk loading operations
    /// </summary>
    public interface IProvideBulkLoadingOperations
    {
        /// <summary>
        /// Loads...
        /// </summary>
        /// <param name="intoSource">into source.</param>
        /// <param name="onMaster">on master.</param>
        /// <param name="fromInputFile">from input file.</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        Task Load(IConnectionDetail intoSource, IConnectionDetail onMaster, string fromInputFile);
    }
}
