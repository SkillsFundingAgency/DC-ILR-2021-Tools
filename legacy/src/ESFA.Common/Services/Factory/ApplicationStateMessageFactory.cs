using ESFA.Common.Model;
using ESFA.Common.Set;
using System.Composition;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// the console message factory
    /// </summary>
    /// <seealso cref="ICreateConsoleMessages" />
    [Shared]
    [Export(typeof(ICreateApplicationStateMessages))]
    public sealed class ApplicationStateMessageFactory :
        ICreateApplicationStateMessages
    {
        /// <summary>
        /// Creates the specified change state message.
        /// </summary>
        /// <param name="newState">The new state.</param>
        /// <returns>a new state message</returns>
        public ICarryChangeStateMessage Create(BusyState newState)
        {
            return new ChangeStateMessage { Payload = newState };
        }
    }
}
