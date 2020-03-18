using ESFA.Common.Composition;

namespace EasyOPA.Composition
{
    /// <summary>
    /// user interaction states
    /// </summary>

    public sealed class EasyOPAInteractionState : InteractionState
    {
        /// <summary>
        /// is modal, manage preparation (popup)
        /// </summary>
        public const int IsModalManagePreparation = 1 << 5;

        /// <summary>
        /// is modal, manage rule selection (popup)
        /// </summary>
        public const int IsModalManageRuleSelection = 1 << 6;

        /// <summary>
        /// is modal manage provider selection (popup)
        /// </summary>
        public const int IsModalManageProviderSelection = 1 << 7;
    }
}
