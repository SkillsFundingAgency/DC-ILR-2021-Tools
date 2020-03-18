using ESFA.Common.Model;
using ESFA.Common.Set;

namespace ESFA.Common.Factory
{
    /// <summary>
    /// i create application state messages
    /// </summary>
    public interface ICreateApplicationStateMessages
    {
        ICarryChangeStateMessage Create(BusyState newState);
    }
}
