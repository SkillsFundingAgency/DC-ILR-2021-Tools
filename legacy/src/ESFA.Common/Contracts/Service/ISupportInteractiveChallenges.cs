namespace ESFA.Common.Service
{
    /// <summary>
    /// i support interactive challenges
    /// </summary>
    public interface ISupportInteractiveChallenges
    {
        bool GetResponse(string forChallenge);
    }
}
