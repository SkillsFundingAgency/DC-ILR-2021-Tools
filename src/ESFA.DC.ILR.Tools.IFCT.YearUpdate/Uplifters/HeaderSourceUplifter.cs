using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderSourceUplifter
        : AbstractUplifter<MessageHeaderSource>, IUplifter<MessageHeaderSource>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime> _standardDateUplifter;

        private readonly Expression<Func<MessageHeaderSource, DateTime>> _selecterFunc = s => s.DateTime;
        private readonly Func<MessageHeaderSource, DateTime> _compiledSelector;

        public HeaderSourceUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();

            _compiledSelector = _selecterFunc.Compile();
        }

        public MessageHeaderSource Process(MessageHeaderSource model)
        {
            ApplyCompiledRule(_selecterFunc, _compiledSelector, _standardDateUplifter.Definition, model);

            return model;
        }
    }
}
