using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the scoped logging notification message
    /// </summary>
    /// <seealso cref="CarryMessage{PayloadValueType{bool}}" />
    /// <seealso cref="ICarryScopedLoggingNotificiationMessage" />
    public sealed class ScopedLogginingNotificationMessage :
        CarryMessage<PayloadValueType<bool>>,
        ICarryScopedLoggingNotificiationMessage
    {
    }
}
