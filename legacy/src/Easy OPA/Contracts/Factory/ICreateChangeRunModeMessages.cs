using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Factory
{
    public interface ICreateChangeRunModeMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns>
        /// a run mode change message
        /// </returns>
        IChangeRunModeMessage Create(TypeOfRunMode runMode);
    }
}
