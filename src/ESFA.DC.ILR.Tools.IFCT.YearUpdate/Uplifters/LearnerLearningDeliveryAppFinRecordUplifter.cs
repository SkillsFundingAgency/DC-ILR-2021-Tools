using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearningDeliveryAppFinRecordUplifter
        : AbstractUplifter<MessageLearnerLearningDeliveryAppFinRecord>, IUplifter<MessageLearnerLearningDeliveryAppFinRecord>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerLearningDeliveryAppFinRecord, DateTime?>> _selecterFuncAFinDate = s => s.AFinDate;
        private readonly Func<MessageLearnerLearningDeliveryAppFinRecord, DateTime?> _compiledSelectorAFinDate;

        public LearnerLearningDeliveryAppFinRecordUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorAFinDate = _selecterFuncAFinDate.Compile();
        }

        public MessageLearnerLearningDeliveryAppFinRecord Process(MessageLearnerLearningDeliveryAppFinRecord model)
        {
            ApplyCompiledRule(_selecterFuncAFinDate, _compiledSelectorAFinDate, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
