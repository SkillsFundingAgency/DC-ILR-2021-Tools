using ESFA.Common.Model;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// i create path monitorng requests
    /// </summary>
    public interface ICreatePathMonitoringRequests
    {
        /// <summary>
        /// Creates (a monitoring request)
        /// </summary>
        /// <param name="forPath">for path.</param>
        /// <param name="andFileType">and file type.</param>
        /// <returns>the request message details</returns>
        ICarryMonitorRequestMessage Create(string forPath, string andFileType);

        /// <summary>
        /// Creates a cease monitoring message
        /// </summary>
        /// <returns>a cease monitoring message</returns>
        ICarryCeaseMonitoringMessage Create();
    }
}
