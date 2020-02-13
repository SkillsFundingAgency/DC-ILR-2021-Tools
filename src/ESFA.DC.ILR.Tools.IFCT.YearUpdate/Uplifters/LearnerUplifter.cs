using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerUplifter
        : AbstractUplifter<MessageLearner>, IUplifter<MessageLearner>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearner, DateTime?>> _selecterFuncDateOfBirth = s => s.DateOfBirth;
        private readonly Func<MessageLearner, DateTime?> _compiledSelectorDateOfBirth;

        public LearnerUplifter(
            IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorDateOfBirth = _selecterFuncDateOfBirth.Compile();
        }

        public MessageLearner Process(MessageLearner model)
        {
            ApplyCompiledRule(_selecterFuncDateOfBirth, _compiledSelectorDateOfBirth, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
