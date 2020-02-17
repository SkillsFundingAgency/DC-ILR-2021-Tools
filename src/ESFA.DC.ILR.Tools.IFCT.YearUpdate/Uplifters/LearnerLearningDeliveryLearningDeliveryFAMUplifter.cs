using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryLearningDeliveryFAMUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>, IUplifter<MessageLearnerLearningDeliveryLearningDeliveryFAM>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?>> _selecterFuncLearnDelFAMDateFrom = s => s.LearnDelFAMDateFrom;
        private readonly Func<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?> _compiledSelectorLearnDelFAMDateFrom;
        private readonly Expression<Func<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?>> _selecterFuncLearnDelFAMDateTo = s => s.LearnDelFAMDateTo;
        private readonly Func<MessageLearnerLearningDeliveryLearningDeliveryFAM, DateTime?> _compiledSelectorLearnDelFAMDateTo;

        public LearnerLearningDeliveryLearningDeliveryFAMUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorLearnDelFAMDateFrom = _selecterFuncLearnDelFAMDateFrom.Compile();
            _compiledSelectorLearnDelFAMDateTo = _selecterFuncLearnDelFAMDateTo.Compile();
        }

        public MessageLearnerLearningDeliveryLearningDeliveryFAM Process(MessageLearnerLearningDeliveryLearningDeliveryFAM model)
        {
            ApplyCompiledRule(_selecterFuncLearnDelFAMDateFrom, _compiledSelectorLearnDelFAMDateFrom, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncLearnDelFAMDateTo, _compiledSelectorLearnDelFAMDateTo, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
