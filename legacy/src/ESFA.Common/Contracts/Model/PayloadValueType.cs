using System;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the value type message payload
    /// </summary>
    /// <typeparam name="TItem">The type of the item.</typeparam>
    public sealed class PayloadValueType<TItem>
        where TItem : struct, IComparable, IConvertible
    {
        /// <summary>
        /// Gets or sets the message.
        /// </summary>
        public TItem Message { get; set; }

        /// <summary>
        /// Performs an implicit conversion from a type of TItem to <see cref="PayloadValueType{TItem}" />.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns>
        /// The result of the conversion.
        /// </returns>
        public static implicit operator PayloadValueType<TItem>(TItem message)
        {
            return new PayloadValueType<TItem> { Message = message };
        }

        /// <summary>
        /// Performs an implicit conversion from <see cref="PayloadValueType{TItem}" /> to a type of TItem />.
        /// </summary>
        /// <param name="payload">The payload.</param>
        /// <returns>
        /// The result of the conversion.
        /// </returns>
        public static implicit operator TItem(PayloadValueType<TItem> payload)
        {
            return payload.Message;
        }
    }
}
