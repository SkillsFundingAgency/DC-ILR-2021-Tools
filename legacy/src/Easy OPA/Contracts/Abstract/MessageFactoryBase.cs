using EasyOPA.Factory;
using Tiny.Framework.Abstracts;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// the message factory abstract base
    /// </summary>
    /// <typeparam name="TMessage">The type of message.</typeparam>
    /// <typeparam name="TMessageContract">The type of message contract.</typeparam>
    /// <typeparam name="TMessagePayload">The type of message payload.</typeparam>
    /// <seealso cref="Factory.ICreateMessages{TMessageContract, TMessagePayload}" />
    public abstract class MessageFactoryBase<TMessage, TMessageContract, TMessagePayload> :
        ICreateMessages<TMessageContract, TMessagePayload>
        where TMessage : CarryMessage<TMessagePayload>, TMessageContract, new()
        where TMessagePayload : class
        where TMessageContract : class
    {
        public TMessageContract Create(TMessagePayload payload)
        {
            return new TMessage { Payload = payload };
        }
    }
}
