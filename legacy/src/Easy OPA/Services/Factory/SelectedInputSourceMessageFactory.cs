using EasyOPA.Abstract;
using EasyOPA.Model;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    /// the input source selected message factory
    /// </summary>
    /// <seealso cref="ICreateSelectedInputSourceMessages" />
    [Shared, Export(typeof(ICreateSelectedInputSourceMessages))]
    public sealed class SelectedInputSourceMessageFactory :
        MessageFactoryBase<SelectedInputSourceMessage, ISelectedInputSourceMessage, IInputDataSource>,
        ICreateSelectedInputSourceMessages
    {
    }
}
