using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the cease monitorng message
    /// </summary>
    /// <seealso cref="CarryMessage{PayloadValueType{bool}}" />
    /// <seealso cref="ICarryCeaseMonitoringMessage" />
    public sealed class CeaseMonitoringMessage :
        CarryMessage<PayloadValueType<bool>>,
        ICarryCeaseMonitoringMessage
    {
    }
}
