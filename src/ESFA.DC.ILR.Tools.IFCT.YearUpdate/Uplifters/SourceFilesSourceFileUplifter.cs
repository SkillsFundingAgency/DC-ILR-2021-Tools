using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class SourceFilesSourceFileUplifter
        : AbstractUplifter<MessageSourceFilesSourceFile>, IUplifter<MessageSourceFilesSourceFile>
    {
        private readonly IRuleProvider _ruleProvider;

        public SourceFilesSourceFileUplifter(IRuleProvider ruleProvider)
        {
            _ruleProvider = ruleProvider;
        }

        public MessageSourceFilesSourceFile Uplift(MessageSourceFilesSourceFile model)
        {
            var standardDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime>();
            var standardNullableDateUplifter = _ruleProvider.BuildStandardDateUplifter<DateTime?>();

            ApplyRule(sf => sf.FilePreparationDate, standardDateUplifter.Definition, model);
            ApplyRule(sf => sf.DateTime, standardNullableDateUplifter.Definition, model);

            return model;
        }
    }
}
