using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?>> _selecterFuncWorkPlaceStartDate = s => s.WorkPlaceStartDate;
        private readonly Func<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?> _compiledSelectorWorkPlaceStartDate;
        private readonly Expression<Func<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?>> _selecterFuncWorkPlaceEndDate = s => s.WorkPlaceEndDate;
        private readonly Func<MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, DateTime?> _compiledSelectorWorkPlaceEndDate;

        public LearnerLearningDeliveryLearningDeliveryWorkPlacementUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorWorkPlaceStartDate = _selecterFuncWorkPlaceStartDate.Compile();
            _compiledSelectorWorkPlaceEndDate = _selecterFuncWorkPlaceEndDate.Compile();
        }

        public MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement Process(MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement model)
        {
            ApplyCompiledRule(_selecterFuncWorkPlaceStartDate, _compiledSelectorWorkPlaceStartDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncWorkPlaceEndDate, _compiledSelectorWorkPlaceEndDate, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
