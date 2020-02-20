using System.Collections.Generic;
using Tiny.Framework.Abstracts;

namespace EasyOPA.Model
{
    /// <summary>
    /// ruleset configuration changed message
    /// </summary>
    /// <seealso cref="CarryMessage{IReadOnlyCollection{IRulebaseConfiguration}}" />
    /// <seealso cref="IRulesetConfigurationChangedMessage" />
    public sealed class RulesetConfigurationChangedMessage :
        CarryMessage<IReadOnlyCollection<IRulebaseConfiguration>>,
        IRulesetConfigurationChangedMessage
    {
    }
}
