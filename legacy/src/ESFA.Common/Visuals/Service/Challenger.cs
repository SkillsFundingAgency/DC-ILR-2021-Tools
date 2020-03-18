using System.Composition;
using System.Windows;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the message box confirmation dialog
    /// </summary>
    /// <seealso cref="ISupportInteractiveChallenges" />
    [Shared]
    [Export(typeof(ISupportInteractiveChallenges))]
    public sealed class Challenger :
        ISupportInteractiveChallenges
    {
        public bool GetResponse(string forChallenge)
        {
            return MessageView.Show(forChallenge, "Please confirm...", MessageBoxButton.YesNo) == MessageBoxResult.Yes;
        }
    }
}
