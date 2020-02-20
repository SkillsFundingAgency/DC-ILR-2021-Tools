using EasyOPA.Model;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create use experimental items messages
    /// </summary>
    /// <seealso cref="ICreateUseExperimentalItemsMessages" />
    [Shared]
    [Export(typeof(ICreateUseExperimentalItemsMessages))]
    public sealed class UseExperimentalItemsMessageFactory :
    ICreateUseExperimentalItemsMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="useExperimentalItems"></param>
        /// <returns>
        /// a use experimental items signal message
        /// </returns>
        public IUseExperimentalItemsMessage Create(bool useExperimentalItems)
        {
            return new UseExperimentalItemsMessage { Payload = useExperimentalItems };
        }
    }
}
