using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class SourceFilesSourceFileUplifter
        : AbstractUplifter<MessageSourceFilesSourceFile>, IUplifter<MessageSourceFilesSourceFile>
    {
        private readonly IRuleProvider _ruleProvider;
        private readonly IRule<DateTime> _standardDateUplifter;
        private readonly IRule<DateTime?> _standardNullableDateUplifter;

        private readonly Expression<Func<MessageSourceFilesSourceFile, DateTime>> _selecterFuncFilePreparationDate = s => s.FilePreparationDate;
        private readonly Func<MessageSourceFilesSourceFile, DateTime> _compiledSelectorFilePreparationDate;
        private readonly Expression<Func<MessageSourceFilesSourceFile, DateTime?>> _selecterFuncDateTime = s => s.DateTime;
        private readonly Func<MessageSourceFilesSourceFile, DateTime?> _compiledSelectorDateTime;

        public SourceFilesSourceFileUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
            _standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();
            _standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            _compiledSelectorFilePreparationDate = _selecterFuncFilePreparationDate.Compile();
            _compiledSelectorDateTime = _selecterFuncDateTime.Compile();
        }

        public MessageSourceFilesSourceFile Process(MessageSourceFilesSourceFile model)
        {
            ApplyCompiledRule(_selecterFuncFilePreparationDate, _compiledSelectorFilePreparationDate, _standardDateUplifter.Definition, model);
            ApplyCompiledRule(_selecterFuncDateTime, _compiledSelectorDateTime, _standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
