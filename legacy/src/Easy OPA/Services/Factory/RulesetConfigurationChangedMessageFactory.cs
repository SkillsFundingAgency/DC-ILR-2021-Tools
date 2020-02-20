using EasyOPA.Abstract;
using EasyOPA.Model;
using System.Collections.Generic;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    ///  ruleset configuration changed message factory
    /// </summary>
    /// <seealso cref="ICreateRulesetConfigurationChangedMessages" />
    [Shared]
    [Export(typeof(ICreateRulesetConfigurationChangedMessages))]
    public sealed class RulesetConfigurationChangedMessageFactory :
        MessageFactoryBase<RulesetConfigurationChangedMessage, IRulesetConfigurationChangedMessage, IReadOnlyCollection<IRulebaseConfiguration>>,
        ICreateRulesetConfigurationChangedMessages
    {
    }
}
