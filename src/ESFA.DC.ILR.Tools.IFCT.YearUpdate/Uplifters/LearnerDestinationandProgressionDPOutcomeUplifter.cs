using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerDestinationandProgressionDPOutcomeUplifter
        : AbstractUplifter<MessageLearnerDestinationandProgressionDPOutcome>, IUplifter<MessageLearnerDestinationandProgressionDPOutcome>
    {
        private readonly IRuleProvider _ruleProvider;

        public LearnerDestinationandProgressionDPOutcomeUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageLearnerDestinationandProgressionDPOutcome Uplift(MessageLearnerDestinationandProgressionDPOutcome model)
        {
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(s => s.OutStartDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.OutEndDate, standardNullableDateUplifter.Definition, model);
            ApplyRule(s => s.OutCollDate, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
