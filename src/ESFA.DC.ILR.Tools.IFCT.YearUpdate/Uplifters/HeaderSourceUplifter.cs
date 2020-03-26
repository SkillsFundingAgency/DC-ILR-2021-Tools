using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderSourceUplifter
        : AbstractUplifter<MessageHeaderSource>, IUplifter<MessageHeaderSource>
    {
        private readonly FieldUpdateProperties<MessageHeaderSource, DateTime> _dateTimeProps;

        public HeaderSourceUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _dateTimeProps = new FieldUpdateProperties<MessageHeaderSource, DateTime>(
                yearUpdateConfiguration.ShouldUpdateDate(typeof(MessageHeaderSource).Name, "DateTime"),
                s => s.DateTime,
                ruleProvider.BuildStandardDateUplifter<DateTime>().Definition);
        }

        public MessageHeaderSource Process(MessageHeaderSource model)
        {
            ApplyRule(_dateTimeProps, model);

            return model;
        }
    }
}
