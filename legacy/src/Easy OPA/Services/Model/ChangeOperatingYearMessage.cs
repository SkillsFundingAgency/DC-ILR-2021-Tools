using Tiny.Framework.Abstracts;

namespace EasyOPA.Model
{
    /// <summary>
    /// the change operating year message
    /// </summary>
    /// <seealso cref="Tiny.Framework.Abstracts.CarryMessage{IYearCollection}" />
    /// <seealso cref="IChangeOperatingYearMessage" />
    public sealed class ChangeOperatingYearMessage :
        CarryMessage<IYearCollection>,
        IChangeOperatingYearMessage
    {
    }
}
