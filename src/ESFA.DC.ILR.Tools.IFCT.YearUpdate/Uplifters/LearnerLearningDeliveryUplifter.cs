using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryUplifter
        : AbstractUplifter<MessageLearnerLearningDelivery>, IUplifter<MessageLearnerLearningDelivery>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM> _learnerLearningDeliveryLearningDeliveryFAMUplifter;
        private readonly IUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement> _learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter;
        private readonly IUplifter<MessageLearnerLearningDeliveryAppFinRecord> _learnerLearningDeliveryAppFinRecordUplifter;

        public LearnerLearningDeliveryUplifter(
            IRuleProvider ruleProvider,
            IUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM> learnerLearningDeliveryLearningDeliveryFAMUplifter,
            IUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement> learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter,
            IUplifter<MessageLearnerLearningDeliveryAppFinRecord> learnerLearningDeliveryAppFinRecordUplifter)
        {
            _ruleProvider = ruleProvider;
            _learnerLearningDeliveryLearningDeliveryFAMUplifter = learnerLearningDeliveryLearningDeliveryFAMUplifter;
            _learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter = learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter;
            _learnerLearningDeliveryAppFinRecordUplifter = learnerLearningDeliveryAppFinRecordUplifter;
        }

        public MessageLearnerLearningDelivery Uplift(MessageLearnerLearningDelivery model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.LearnStartDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.OrigLearnStartDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.LearnPlanEndDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.LearnActEndDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.AchDate, standardNullableDateUplifter.Definition, model);

            ApplyGroupChildRule(m => m.LearningDeliveryFAM, _learnerLearningDeliveryLearningDeliveryFAMUplifter, model);
            ApplyGroupChildRule(m => m.LearningDeliveryWorkPlacement, _learnerLearningDeliveryLearningDeliveryWorkPlacementUplifter, model);
            ApplyGroupChildRule(m => m.AppFinRecord, _learnerLearningDeliveryAppFinRecordUplifter, model);

            return model;
        }
    }
}
