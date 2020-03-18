using EasyOPA.Abstract;
using System;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// the input source learning provider detail wrapper
    /// this is a visual binding class
    /// </summary>
    /// <seealso cref="ObservableBase" />
    public sealed class LearningProviderWrapper :
        VisualBindingWrapper<ILearningProvider>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="LearningProviderWrapper"/> class.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <param name="count">The count.</param>
        /// <param name="details">The details.</param>
        /// <param name="stateChangeAction">The state change action.</param>
        public LearningProviderWrapper(ILearningProvider source, int count, IProviderDetails details, Action stateChangeAction) :
            base(source, stateChangeAction)
        {
            LearnerCount = count;
            source.LearnerCount = count;
            Address = SetAddress(details);
        }

        /// <summary>
        /// Gets the learner count.
        /// </summary>
        public int LearnerCount { get; }

        /// <summary>
        /// Gets the address details.
        /// </summary>
        public string Address { get; }

        /// <summary>
        /// Sets the address.
        /// </summary>
        /// <param name="details">The details.</param>
        public string SetAddress(IProviderDetails details)
        {
            if (It.IsNull(details))
            {
                return null;
            }

            It.IsOutOfRange(details.UKPRN, Source.ID)
                .AsGuard<ArgumentException>(nameof(details.UKPRN));

            // cleanse the input, remove missing bit's so it displays ok.
            var temp = $"{details.Name}#{details.Location}#{details.Street}#{details.Town}#{details.Postcode}";
            return string.Join(",\r\n", temp.Split(new char[] { '#' }, StringSplitOptions.RemoveEmptyEntries));
        }
    }
}
