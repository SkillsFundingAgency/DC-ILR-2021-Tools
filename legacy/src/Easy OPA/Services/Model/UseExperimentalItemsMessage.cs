using ESFA.Common.Model;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// the signal message to load experimental items
    /// </summary>
    /// <seealso cref="CarryMessage{PayloadValueType{bool}}" />
    /// <seealso cref="ISelectedInputSourceMessage" />
    public sealed class UseExperimentalItemsMessage :
        CarryMessage<PayloadValueType<bool>>,
        IUseExperimentalItemsMessage
    {
    }
}
