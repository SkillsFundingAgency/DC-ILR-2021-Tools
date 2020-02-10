using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryFAMUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>
    {
        private readonly IRuleProvider _ruleProvider;

        public LearnerLearningDeliveryLearningDeliveryFAMUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageLearnerLearningDeliveryLearningDeliveryFAM Uplift(MessageLearnerLearningDeliveryLearningDeliveryFAM model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.LearnDelFAMDateFrom, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.LearnDelFAMDateTo, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
