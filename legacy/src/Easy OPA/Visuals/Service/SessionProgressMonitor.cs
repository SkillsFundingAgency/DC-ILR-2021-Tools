using System.Composition;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Utilities;

namespace EasyOPA.Service
{
    /// <summary>
    /// the progress monitor
    /// </summary>
    [Shared]
    [Export(typeof(IMonitorSessionProgress))]
    public sealed class SessionProgressMonitor :
        ObservableBase,
        IMonitorSessionProgress
    {
        /// <summary>
        /// The provider count
        /// </summary>
        private int _providerCount;

        /// <summary>
        /// Gets or sets the provider count.
        /// </summary>
        public int ProviderCount
        {
            get { return _providerCount; }
            set { SetPropertyValue(ref _providerCount, value); }
        }

        /// <summary>
        /// The provider position
        /// </summary>
        private int _providerPosition;

        /// <summary>
        /// Gets the session position.
        /// </summary>
        public int ProviderPosition
        {
            get { return _providerPosition; }
            set { SetPropertyValue(ref _providerPosition, value); }
        }

        /// <summary>
        /// show position
        /// </summary>
        private bool _showPosition;

        /// <summary>
        /// Gets or sets a value indicating whether [show position].
        /// </summary>
        public bool ShowPosition
        {
            get { return _showPosition; }
            set { SetPropertyValue(ref _showPosition, value); }
        }

        /// <summary>
        /// Increments the position.
        /// </summary>
        public void IncrementPosition()
        {
            ProviderPosition++;

            // on a neew provider so all counts are off!
            InvalidLearnerCount = 0;
            TotalLearnerCount = 0;
            ValidLearnerCount = 0;
            RulebaseCaseDetails = null;

            ShowPosition = (ProviderCount > 1) && (ProviderPosition <= ProviderCount);
        }

        /// <summary>
        /// Sets the position.
        /// </summary>
        /// <param name="newCount">The new count.</param>
        public void SetProviderCount(int newCount)
        {
            ProviderPosition = 0;
            ProviderCount = newCount;

            ShowPosition = ProviderCount > 1;
        }

        /// <summary>
        /// show counts
        /// </summary>
        private bool _showCounts;

        /// <summary>
        /// Gets or sets a value indicating whether [show counts].
        /// </summary>
        public bool ShowCounts
        {
            get { return _showCounts; }
            set { SetPropertyValue(ref _showCounts, value); }
        }

        /// <summary>
        /// The invalid learner count
        /// </summary>
        private int _invalidLearnerCount;

        /// <summary>
        /// Gets or sets the invalid learner count.
        /// </summary>
        public int InvalidLearnerCount
        {
            get { return _invalidLearnerCount; }
            set { SetPropertyValue(ref _invalidLearnerCount, value); }
        }

        /// <summary>
        /// The total learner count
        /// </summary>
        private int _totalLearnerCount;

        /// <summary>
        /// Gets or sets the total learner count.
        /// </summary>
        public int TotalLearnerCount
        {
            get { return _totalLearnerCount; }
            set { SetPropertyValue(ref _totalLearnerCount, value); }
        }

        /// <summary>
        /// The valid learner count
        /// </summary>
        private int _validLearnerCount;

        /// <summary>
        /// Gets or sets the valid learner count.
        /// </summary>
        public int ValidLearnerCount
        {
            get { return _validLearnerCount; }
            set { SetPropertyValue(ref _validLearnerCount, value); }
        }

        /// <summary>
        /// Sets the learner counts.
        /// </summary>
        /// <param name="invalid">The invalid.</param>
        /// <param name="total">The total.</param>
        /// <param name="valid">The valid.</param>
        public void SetLearnerCounts(int invalid, int total, int valid)
        {
            InvalidLearnerCount = invalid;
            TotalLearnerCount = total;
            ValidLearnerCount = valid;

            ShowCounts = TotalLearnerCount > 0;
        }

        /// <summary>
        /// The rulebase case details
        /// </summary>
        private string _rulebaseCaseDetails;

        /// <summary>
        /// Gets or sets the rulebase case details.
        /// </summary>
        public string RulebaseCaseDetails
        {
            get { return _rulebaseCaseDetails; }
            set { SetPropertyValue(ref _rulebaseCaseDetails, value); }
        }

        /// <summary>
        /// Sets the case count.
        /// </summary>
        /// <param name="shortName">The short name.</param>
        /// <param name="count">The count.</param>
        public void SetCaseCount(string shortName, int count)
        {
            RulebaseCaseDetails = It.Has(shortName) ? $"{shortName}: {count}" : null;
        }
    }
}
