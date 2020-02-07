using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearnerEmploymentStatusUplifter
        : AbstractUplifter<MessageLearnerLearnerEmploymentStatus>, IUplifter<MessageLearnerLearnerEmploymentStatus>
    {
        private readonly IRuleProvider _ruleProvider;

        public LearnerLearnerEmploymentStatusUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageLearnerLearnerEmploymentStatus Uplift(MessageLearnerLearnerEmploymentStatus model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.DateEmpStatApp, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
