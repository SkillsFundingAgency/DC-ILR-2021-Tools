using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearnerEmploymentStatusUplifter
        : AbstractUplifter<MessageLearnerLearnerEmploymentStatus>, IUplifter<MessageLearnerLearnerEmploymentStatus>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageLearnerLearnerEmploymentStatus, DateTime?>> _selecterFuncDateEmpStatApp = s => s.DateEmpStatApp;
        private readonly Func<MessageLearnerLearnerEmploymentStatus, DateTime?> _compiledSelectorDateEmpStatApp;

        public LearnerLearnerEmploymentStatusUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorDateEmpStatApp = _selecterFuncDateEmpStatApp.Compile();
        }

        public MessageLearnerLearnerEmploymentStatus Process(MessageLearnerLearnerEmploymentStatus model)
        {
            ApplyCompiledRule(_selecterFuncDateEmpStatApp, _compiledSelectorDateEmpStatApp, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
