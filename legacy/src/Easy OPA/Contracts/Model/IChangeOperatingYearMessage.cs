using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// i carry (a) change collection configuration message
    /// </summary>
    /// <seealso cref="Tiny.Framework.Contracts.Message.ICarryMessage{IYearCollection}" />
    /// <seealso cref="ICarryMessage{IInputDataSource}" />
    public interface IChangeOperatingYearMessage :
        ICarryMessage<IYearCollection>
    {
    }
}
