using EasyOPA.Model;

namespace EasyOPA.Factory
{
    public interface ICreateUseExperimentalItemsMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns>
        /// an signal to use experimetnal items
        /// </returns>
        IUseExperimentalItemsMessage Create(bool useExperimentalItems);
    }
}
