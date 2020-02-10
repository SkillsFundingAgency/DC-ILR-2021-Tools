using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderCollectionDetailsUplifter
        : AbstractUplifter<MessageHeaderCollectionDetails>, IUplifter<MessageHeaderCollectionDetails>
    {
        private readonly IRuleProvider _ruleProvider;

        public HeaderCollectionDetailsUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageHeaderCollectionDetails Uplift(MessageHeaderCollectionDetails model)
        {
            var standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();

            ApplyRule(s => s.FilePreparationDate, standardDateUplifter.Definition, model);

            return model;
        }
    }
}
