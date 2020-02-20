using Tiny.Framework.Contracts.Message;

namespace ESFA.Common.Model
{
    /// <summary>
    /// i carry (a) 'console' message
    /// </summary>
    /// <seealso cref="ICarryMessage{string}" />
    public interface ICarryConsoleMessage : 
        ICarryMessage<string>
    {
    }
}
