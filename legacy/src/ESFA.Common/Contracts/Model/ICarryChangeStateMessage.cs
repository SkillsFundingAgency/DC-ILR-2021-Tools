using ESFA.Common.Set;
using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// i carry (a) state change message
    /// </summary>
    /// <seealso cref="ICarryMessage{PayloadValueType{BusyState}}" />
    public interface ICarryChangeStateMessage :
        ICarryMessage<PayloadValueType<BusyState>>
    {
    }
}
