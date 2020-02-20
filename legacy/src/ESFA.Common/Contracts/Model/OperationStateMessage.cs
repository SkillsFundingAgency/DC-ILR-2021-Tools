using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// an operation state message
    /// internalised so it can't be seen outside this library (as it doesn't need to be)
    /// </summary>
    /// <seealso cref="CarryMessage{IOperationResponse}" />
    /// <seealso cref="ICarryLastOperationState" />
    internal class OperationStateMessage :
        CarryMessage<IOperationResponse>,
        ICarryLastOperationState
    {
    }
}
