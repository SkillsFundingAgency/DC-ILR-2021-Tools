using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryUplifter
        : AbstractUplifter<MessageLearnerLearningDelivery>, IUplifter<MessageLearnerLearningDelivery>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerLearningDelivery, DateTime?>> _selecterFuncLearnStartDate = s => s.LearnStartDate;
        private readonly Func<MessageLearnerLearningDelivery, DateTime?> _compiledSelectorLearnStartDate;
        private readonly Expression<Func<MessageLearnerLearningDelivery, DateTime?>> _selecterFuncOrigLearnStartDate = s => s.OrigLearnStartDate;
        private readonly Func<MessageLearnerLearningDelivery, DateTime?> _compiledSelectorOrigLearnStartDate;
        private readonly Expression<Func<MessageLearnerLearningDelivery, DateTime?>> _selecterFuncLearnPlanEndDate = s => s.LearnPlanEndDate;
        private readonly Func<MessageLearnerLearningDelivery, DateTime?> _compiledSelectorLearnPlanEndDate;
        private readonly Expression<Func<MessageLearnerLearningDelivery, DateTime?>> _selecterFuncLearnActEndDate = s => s.LearnActEndDate;
        private readonly Func<MessageLearnerLearningDelivery, DateTime?> _compiledSelectorLearnActEndDate;
        private readonly Expression<Func<MessageLearnerLearningDelivery, DateTime?>> _selecterFuncAchDate = s => s.AchDate;
        private readonly Func<MessageLearnerLearningDelivery, DateTime?> _compiledSelectorAchDate;

        public LearnerLearningDeliveryUplifter(
            IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorLearnStartDate = _selecterFuncLearnStartDate.Compile();
            _compiledSelectorOrigLearnStartDate = _selecterFuncOrigLearnStartDate.Compile();
            _compiledSelectorLearnPlanEndDate = _selecterFuncLearnPlanEndDate.Compile();
            _compiledSelectorLearnActEndDate = _selecterFuncLearnActEndDate.Compile();
            _compiledSelectorAchDate = _selecterFuncAchDate.Compile();
        }

        public MessageLearnerLearningDelivery Process(MessageLearnerLearningDelivery model)
        {
            ApplyCompiledRule(_selecterFuncLearnStartDate, _compiledSelectorLearnStartDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncOrigLearnStartDate, _compiledSelectorOrigLearnStartDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncLearnPlanEndDate, _compiledSelectorLearnPlanEndDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncLearnActEndDate, _compiledSelectorLearnActEndDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncAchDate, _compiledSelectorAchDate, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
