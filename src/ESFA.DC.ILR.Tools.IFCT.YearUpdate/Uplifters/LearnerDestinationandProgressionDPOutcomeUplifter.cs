using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerDestinationandProgressionDPOutcomeUplifter
        : AbstractUplifter<MessageLearnerDestinationandProgressionDPOutcome>, IUplifter<MessageLearnerDestinationandProgressionDPOutcome>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>> _selecterFuncOutStartDate = s => s.OutStartDate;
        private readonly Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _compiledSelectorOutStartDate;
        private readonly Expression<Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>> _selecterFuncOutEndDate = s => s.OutEndDate;
        private readonly Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _compiledSelectorOutEndDate;
        private readonly Expression<Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>> _selecterFuncOutCollDate = s => s.OutCollDate;
        private readonly Func<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _compiledSelectorOutCollDate;

        public LearnerDestinationandProgressionDPOutcomeUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorOutStartDate = _selecterFuncOutStartDate.Compile();
            _compiledSelectorOutEndDate = _selecterFuncOutEndDate.Compile();
            _compiledSelectorOutCollDate = _selecterFuncOutCollDate.Compile();
        }

        public MessageLearnerDestinationandProgressionDPOutcome Process(MessageLearnerDestinationandProgressionDPOutcome model)
        {
            ApplyCompiledRule(_selecterFuncOutStartDate, _compiledSelectorOutStartDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncOutEndDate, _compiledSelectorOutEndDate, _standardNullableDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncOutCollDate, _compiledSelectorOutCollDate, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
