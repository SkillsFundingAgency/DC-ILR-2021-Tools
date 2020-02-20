using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// i carry (the) last operation state
    /// </summary>
    /// <seealso cref="ICarryMessage{IOperationResponse}" />
    public interface ICarryLastOperationState :
        ICarryMessage<IOperationResponse>
    {
    }
}
