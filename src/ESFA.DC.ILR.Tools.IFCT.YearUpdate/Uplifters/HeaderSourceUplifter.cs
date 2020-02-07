using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderSourceUplifter
        : AbstractUplifter<MessageHeaderSource>, IUplifter<MessageHeaderSource>
    {
        private readonly IRuleProvider _ruleProvider;

        public HeaderSourceUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageHeaderSource Uplift(MessageHeaderSource model)
        {
            var standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();

            ApplyRule(s => s.DateTime, standardDateUplifter.Definition, model);

            return model;
        }
    }
}
