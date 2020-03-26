using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryAppFinRecordUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryAppFinRecord>, IUplifter<MessageLearnerLearningDeliveryAppFinRecord>
    {
        private readonly FieldUpdateProperties<MessageLearnerLearningDeliveryAppFinRecord, DateTime?> _aFinDateProps;

        public LearnerLearningDeliveryAppFinRecordUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _aFinDateProps = new FieldUpdateProperties<MessageLearnerLearningDeliveryAppFinRecord, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(typeof(MessageLearnerLearningDeliveryAppFinRecord).Name, "AFinDate"),
                s => s.AFinDate,
                ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition);
        }

        public MessageLearnerLearningDeliveryAppFinRecord Process(MessageLearnerLearningDeliveryAppFinRecord model)
        {
            ApplyRule(_aFinDateProps, model);

            return model;
        }
    }
}
