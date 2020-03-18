using EasyOPA.Set;
using ESFA.Common.Model;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// the signal message to change run mode
    /// </summary>
    /// <seealso cref="CarryMessage{ValuePayload{TypeOfRunMode}}" />
    /// <seealso cref="ISelectedInputSourceMessage" />
    public sealed class ChangeRunModeMessage :
        CarryMessage<PayloadValueType<TypeOfRunMode>>,
        IChangeRunModeMessage
    {
    }
}
