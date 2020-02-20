using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// i carry (a) 'scoped logging notification'
    /// </summary>
    /// <seealso cref="Tiny.Framework.Contracts.Message.ICarryMessage{PayloadValueType{bool}}" />
    public interface ICarryScopedLoggingNotificiationMessage :
        ICarryMessage<PayloadValueType<bool>>
    {
    }
}
