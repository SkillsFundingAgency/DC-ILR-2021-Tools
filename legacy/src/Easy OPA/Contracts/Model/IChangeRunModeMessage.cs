using EasyOPA.Set;
using ESFA.Common.Model;
using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// i use experimental items message
    /// </summary>
    /// <seealso cref="Tiny.Framework.Contracts.Message.ICarryMessage{ValuePayload{bool}}" />
    public interface IChangeRunModeMessage :
        ICarryMessage<PayloadValueType<TypeOfRunMode>>
    {
    }
}
