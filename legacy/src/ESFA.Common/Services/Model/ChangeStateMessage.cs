using ESFA.Common.Set;
using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the change state message
    /// </summary>
    /// <seealso cref="CarryMessage{PayloadValueType{BusyState}}" />
    /// <seealso cref="ICarryChangeStateMessage" />
    public sealed class ChangeStateMessage :
        CarryMessage<PayloadValueType<BusyState>>,
        ICarryChangeStateMessage
    {
    }
}
