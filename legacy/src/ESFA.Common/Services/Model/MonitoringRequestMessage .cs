using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the monitoring request message
    /// </summary>
    /// <seealso cref="Tiny.Framework.Abstracts.CarryMessage{IRequestPathMonitoring}" />
    /// <seealso cref="ICarryMonitorRequestMessage" />
    public sealed class MonitoringRequestMessage :
        CarryMessage<IRequestPathMonitoring>,
        ICarryMonitorRequestMessage
    {
    }
}
