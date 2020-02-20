using EasyOPA.Model;
using System.Collections.Generic;

namespace EasyOPA.Factory
{
    /// <summary>
    ///  i create ruleset configuration changed messages
    /// </summary>
    public interface ICreateRulesetConfigurationChangedMessages :
        ICreateMessages<IRulesetConfigurationChangedMessage, IReadOnlyCollection<IRulebaseConfiguration>>
    {
    }
}
