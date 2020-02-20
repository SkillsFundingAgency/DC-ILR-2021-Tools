using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// i carry (an) input source selected message
    /// </summary>
    /// <seealso cref="ICarryMessage{IInputDataSource}" />
    public interface ISelectedInputSourceMessage :
        ICarryMessage<IInputDataSource>
    {
    }
}
