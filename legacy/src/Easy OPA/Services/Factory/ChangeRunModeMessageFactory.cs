using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create change run mode messages
    /// </summary>
    /// <seealso cref="ICreateChangeRunModeMessages" />
    [Shared]
    [Export(typeof(ICreateChangeRunModeMessages))]
    public sealed class ChangeRunModeMessageFactory :
        ICreateChangeRunModeMessages
    {
        /// <summary>
        /// Creates the specified message.
        /// </summary>
        /// <param name="useExperimentalItems"></param>
        /// <returns>
        /// a use experimental items signal message
        /// </returns>
        public IChangeRunModeMessage Create(TypeOfRunMode runMode)
        {
            return new ChangeRunModeMessage { Payload = runMode };
        }
    }
}
