namespace ESFA.Common.Composition
{
    /// <summary>
    /// user interaction states
    /// </summary>
    public class InteractionState
    {
        /// <summary>
        /// idle, open for business...
        /// </summary>
        public const int Idle = 0;

        /// <summary>
        /// is modal, view console (popup)
        /// </summary>
        public const int IsModalViewConsole = 1 << 1;

        /// <summary>
        /// is modal, request help (popup)
        /// </summary>
        public const int IsModalRequestHelp = 1 << 2;

        /// <summary>
        /// i'm busy, i'll be back when i'm done...
        /// </summary>
        public const int IsBusy = 1 << 4;
    }
}
