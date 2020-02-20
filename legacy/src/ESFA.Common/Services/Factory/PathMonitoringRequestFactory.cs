using ESFA.Common.Model;
using System.Composition;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// the path monitoring request factory
    /// </summary>
    /// <seealso cref="ICreatePathMonitoringRequests" />
    [Shared]
    [Export(typeof(ICreatePathMonitoringRequests))]
    public sealed class PathMonitoringRequestFactory :
        ICreatePathMonitoringRequests
    {
        /// <summary>
        /// Creates a cease monitoring message
        /// </summary>
        /// <returns>
        /// a cease monitoring message
        /// </returns>
        public ICarryCeaseMonitoringMessage Create()
        {
            return new CeaseMonitoringMessage { Payload = true };
        }

        /// <summary>
        /// Creates (a monitoring request)
        /// </summary>
        /// <param name="forPath">for path.</param>
        /// <param name="andFileType">and file type.</param>
        /// <returns>
        /// the request message details
        /// </returns>
        public ICarryMonitorRequestMessage Create(string forPath, string andFileType)
        {
            return new MonitoringRequestMessage
            {
                Payload = new MonitorPathRequest
                {
                    MonitorPath = forPath,
                    TargetType = andFileType
                }
            };
        }
    }
}
