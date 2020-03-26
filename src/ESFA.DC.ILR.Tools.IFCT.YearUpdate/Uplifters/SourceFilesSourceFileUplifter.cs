using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class SourceFilesSourceFileUplifter
        : AbstractUplifter<MessageSourceFilesSourceFile>, IUplifter<MessageSourceFilesSourceFile>
    {
        private readonly FieldUpdateProperties<MessageSourceFilesSourceFile, DateTime> _filePreparationDateProps;
        private readonly FieldUpdateProperties<MessageSourceFilesSourceFile, DateTime?> _dateTimeProps;

        public SourceFilesSourceFileUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            var modelName = typeof(MessageSourceFilesSourceFile).Name;

            _filePreparationDateProps = new FieldUpdateProperties<MessageSourceFilesSourceFile, DateTime>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "FilePreparationDate"),
                s => s.FilePreparationDate,
                ruleProvider.BuildStandardDateUplifter<DateTime>().Definition);

            _dateTimeProps = new FieldUpdateProperties<MessageSourceFilesSourceFile, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "DateTime"),
                s => s.DateTime,
                ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition);
        }

        public MessageSourceFilesSourceFile Process(MessageSourceFilesSourceFile model)
        {
            ApplyRule(_filePreparationDateProps, model);
            ApplyRule(_dateTimeProps, model);

            return model;
        }
    }
}
