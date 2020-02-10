using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>
    {
        private readonly IRuleProvider _ruleProvider;

        public LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement Uplift(MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.WorkPlaceStartDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.WorkPlaceEndDate, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
