using EasyOPA.Model;
using System.Collections.Generic;

namespace EasyOPA.Manager
{
    /// <summary>
    /// i manage rules selection
    /// </summary>
    public interface IManageRulesSelection
    {
        /// <summary>
        /// Gets the selected rules.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> SelectedRules { get; }

        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        bool IsValid();
    }
}
