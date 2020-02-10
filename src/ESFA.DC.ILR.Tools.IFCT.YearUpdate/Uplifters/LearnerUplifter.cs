using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerUplifter
        : AbstractUplifter<MessageLearner>, IUplifter<MessageLearner>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IUplifter<MessageLearnerLearnerEmploymentStatus> _learnerLearnerEmploymentStatusUplifter;
        private readonly IUplifter<MessageLearnerLearningDelivery> _learnerLearningDeliveryUplifter;

        public LearnerUplifter(
            IRuleProvider ruleProvider,
            IUplifter<MessageLearnerLearnerEmploymentStatus> learnerLearnerEmploymentStatusUplifter,
            IUplifter<MessageLearnerLearningDelivery> learnerLearningDeliveryUplifter)
        {
            _ruleProvider = ruleProvider;
            _learnerLearnerEmploymentStatusUplifter = learnerLearnerEmploymentStatusUplifter;
            _learnerLearningDeliveryUplifter = learnerLearningDeliveryUplifter;
        }

        public MessageLearner Uplift(MessageLearner model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.DateOfBirth, standardNullableDateUplifter.Definition, model);
            ApplyGroupChildRule(s => s.LearnerEmploymentStatus, _learnerLearnerEmploymentStatusUplifter, model);
            ApplyGroupChildRule(s => s.LearningDelivery, _learnerLearningDeliveryUplifter, model);

            return model;
        }
    }
}
