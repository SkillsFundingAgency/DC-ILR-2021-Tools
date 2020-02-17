using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderCollectionDetailsUplifter
        : AbstractUplifter<MessageHeaderCollectionDetails>, IUplifter<MessageHeaderCollectionDetails>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime> _standardDateUplifter;
        private readonly Expression<Func<MessageHeaderCollectionDetails, DateTime>> _selecterFunc = s => s.FilePreparationDate;
        private readonly Func<MessageHeaderCollectionDetails, DateTime> _compiledSelector;

        public HeaderCollectionDetailsUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();

            _compiledSelector = _selecterFunc.Compile();
        }

        public MessageHeaderCollectionDetails Process(MessageHeaderCollectionDetails model)
        {
            ApplyCompiledRule(_selecterFunc, _compiledSelector, _standardDateUplifter.Definition, model);

            return model;
        }
    }
}
