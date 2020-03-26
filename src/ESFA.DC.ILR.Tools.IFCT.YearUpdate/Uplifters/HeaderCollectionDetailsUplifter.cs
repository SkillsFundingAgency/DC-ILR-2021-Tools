using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderCollectionDetailsUplifter
        : AbstractUplifter<MessageHeaderCollectionDetails>, IUplifter<MessageHeaderCollectionDetails>
    {
        private readonly FieldUpdateProperties<MessageHeaderCollectionDetails, DateTime> _filePreparationDateProps;

        public HeaderCollectionDetailsUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _filePreparationDateProps = new FieldUpdateProperties<MessageHeaderCollectionDetails, DateTime>(
                yearUpdateConfiguration.ShouldUpdateDate(typeof(MessageHeaderCollectionDetails).Name, "FilePreparationDate"),
                s => s.FilePreparationDate,
                ruleProvider.BuildStandardDateUplifter<DateTime>().Definition);
        }

        public MessageHeaderCollectionDetails Process(MessageHeaderCollectionDetails model)
        {
            ApplyRule(_filePreparationDateProps, model);

            return model;
        }
    }
}
