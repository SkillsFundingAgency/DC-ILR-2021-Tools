using EasyOPA.Model;
using System.Threading.Tasks;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide bulk export operations
    /// </summary>
    public interface IProvideBulkExportOperations
    {
        /// <summary>
        /// Exports to ILR
        /// </summary>
        /// <param name="usingSource">using source.</param>
        /// <param name="inContext">in context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <returns>
        /// the currently running task
        /// </returns>
        Task Export(IInputDataSource usingSource, IConnectionDetail inContext, int forProvider);
    }
}
