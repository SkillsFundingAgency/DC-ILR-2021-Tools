using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryAppFinRecordUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryAppFinRecord>, IUplifter<MessageLearnerLearningDeliveryAppFinRecord>
    {
        private readonly IRuleProvider _ruleProvider;

        public LearnerLearningDeliveryAppFinRecordUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageLearnerLearningDeliveryAppFinRecord Uplift(MessageLearnerLearningDeliveryAppFinRecord model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.AFinDate, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
