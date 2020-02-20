using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// i carry (a) monitoring request message
    /// </summary>
    /// <seealso cref="Tiny.Framework.Contracts.Message.ICarryMessage{IRequestMonitorPath}" />
    public interface ICarryMonitorRequestMessage :
        ICarryMessage<IRequestPathMonitoring>
    {
    }
}
