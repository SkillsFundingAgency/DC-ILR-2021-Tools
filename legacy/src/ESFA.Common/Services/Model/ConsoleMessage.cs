using Tiny.Framework.Abstracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the console message (payload)
    /// </summary>
    /// <seealso cref="CarryMessage{string}" />
    /// <seealso cref="ICarryConsoleMessage" />
    public sealed class ConsoleMessage :
        CarryMessage<string>,
        ICarryConsoleMessage
    {
    }
}
