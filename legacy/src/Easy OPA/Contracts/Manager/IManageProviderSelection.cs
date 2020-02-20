using System.Threading.Tasks;

namespace EasyOPA.Manager
{
    /// <summary>
    /// i manage (learning) provider selection
    /// </summary>
    public interface IManageProviderSelection
    {
        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        bool IsValid();

        /// <summary>
        /// Applies the filter.
        /// </summary>
        Task ApplyFilter();
    }
}
