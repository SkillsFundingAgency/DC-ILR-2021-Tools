using ESFA.Common.Model;
using ESFA.Common.Set;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// i manage application state
    /// </summary>
    public interface IManageApplicationState
    {
        /// <summary>
        /// busy scope
        /// </summary>
        /// <param name="returnState">the state to return to.</param>
        /// <returns>
        /// returns an i disposable busy state scope
        /// </returns>
        IScopeBusyState BusyScope(BusyState returnState = BusyState.IsIdle);
    }
}
