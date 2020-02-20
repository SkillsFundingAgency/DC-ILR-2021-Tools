using System.Threading.Tasks;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i validate XML files
    /// </summary>
    public interface IValidateXMLFiles
    {
        /// <summary>
        /// Validates...
        /// </summary>
        /// <param name="thisFile">this file.</param>
        /// <param name="againstThisSchema">against this schema.</param>
        Task<bool> IsValid(string thisFile, string againstThisSchema);
    }
}
