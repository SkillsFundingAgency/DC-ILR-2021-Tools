using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryFAMUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>
    {
        private readonly FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?> _learnDelFAMDateFromProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?> _learnDelFAMDateToProps;

        public LearnerLearningDeliveryLearningDeliveryFAMUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            var modelName = typeof(MessageLearnerLearningDeliveryLearningDeliveryFAM).Name;
            Func<DateTime?, DateTime?> standardNullableDateUplifter = ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition;

            _learnDelFAMDateFromProps = new FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "LearnDelFAMDateFrom"),
                s => s.LearnDelFAMDateFrom,
                standardNullableDateUplifter);

            _learnDelFAMDateToProps = new FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "LearnDelFAMDateTo"),
                s => s.LearnDelFAMDateTo,
                standardNullableDateUplifter);
        }

        public MessageLearnerLearningDeliveryLearningDeliveryFAM Process(MessageLearnerLearningDeliveryLearningDeliveryFAM model)
        {
            ApplyRule(_learnDelFAMDateFromProps, model);
            ApplyRule(_learnDelFAMDateToProps, model);

            return model;
        }
    }
}
