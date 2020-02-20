using System.Collections.Generic;
using Tiny.Framework.Contracts.Message;

namespace EasyOPA.Model
{
    /// <summary>
    /// i carry (a) ruleset changed message
    /// </summary>
    /// <seealso cref="ICarryMessage{IReadOnlyCollection{IInputDataSource}}" />
    public interface IRulesetConfigurationChangedMessage :
        ICarryMessage<IReadOnlyCollection<IRulebaseConfiguration>>
    {
    }
}
