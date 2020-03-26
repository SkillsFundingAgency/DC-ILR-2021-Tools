using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryUplifter
        : AbstractUplifter<MessageLearnerLearningDelivery>, IUplifter<MessageLearnerLearningDelivery>
    {
        private readonly FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?> _learnStartDateProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?> _origLearnStartDateProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?> _learnPlanEndDateProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?> _learnActEndDateProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?> _achDateProps;

        public LearnerLearningDeliveryUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            var modelName = typeof(MessageLearnerLearningDelivery).Name;
            Func<DateTime?, DateTime?> standardNullableDateUplifter = ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition;

            _learnStartDateProps = new FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "LearnStartDate"),
                s => s.LearnStartDate,
                standardNullableDateUplifter);

            _origLearnStartDateProps = new FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "OrigLearnStartDate"),
                s => s.OrigLearnStartDate,
                standardNullableDateUplifter);

            _learnPlanEndDateProps = new FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "LearnPlanEndDate"),
                s => s.LearnPlanEndDate,
                standardNullableDateUplifter);

            _learnActEndDateProps = new FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "LearnActEndDate"),
                s => s.LearnActEndDate,
                standardNullableDateUplifter);

            _achDateProps = new FieldUpdateProperties<MessageLearnerLearningDelivery, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "AchDate"),
                s => s.AchDate,
                standardNullableDateUplifter);
        }

        public MessageLearnerLearningDelivery Process(MessageLearnerLearningDelivery model)
        {
            ApplyRule(_learnStartDateProps, model);
            ApplyRule(_origLearnStartDateProps, model);
            ApplyRule(_learnPlanEndDateProps, model);
            ApplyRule(_learnActEndDateProps, model);
            ApplyRule(_achDateProps, model);

            return model;
        }
    }
}
