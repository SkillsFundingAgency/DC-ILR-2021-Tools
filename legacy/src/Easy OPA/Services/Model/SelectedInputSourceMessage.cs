using Tiny.Framework.Abstracts;

namespace EasyOPA.Model
{
    /// <summary>
    /// the input source selected message
    /// </summary>
    /// <seealso cref="CarryMessage{IInputDataSource}" />
    /// <seealso cref="ISelectedInputSourceMessage" />
    public sealed class SelectedInputSourceMessage :  
        CarryMessage<IInputDataSource>,
        ISelectedInputSourceMessage
    {
    }
}
