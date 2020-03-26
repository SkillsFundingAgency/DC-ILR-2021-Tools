using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>
    {
        private readonly FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?> _workPlaceStartDateProps;
        private readonly FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?> _workPlaceEndDateProps;

        public LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            var modelName = typeof(MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement).Name;
            Func<DateTime?, DateTime?> standardNullableDateUplifter = ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition;

            _workPlaceStartDateProps = new FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "WorkPlaceStartDate"),
                s => s.WorkPlaceStartDate,
                standardNullableDateUplifter);

            _workPlaceEndDateProps = new FieldUpdateProperties<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "WorkPlaceEndDate"),
                s => s.WorkPlaceEndDate,
                standardNullableDateUplifter);
        }

        public MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement Process(MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement model)
        {
            ApplyRule(_workPlaceStartDateProps, model);
            ApplyRule(_workPlaceEndDateProps, model);

            return model;
        }
    }
}
