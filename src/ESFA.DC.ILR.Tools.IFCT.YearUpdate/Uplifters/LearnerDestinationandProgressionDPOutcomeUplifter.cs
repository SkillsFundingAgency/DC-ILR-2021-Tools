using System;
using System.Linq.Expressions;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerDestinationandProgressionDPOutcomeUplifter
        : AbstractUplifter<MessageLearnerDestinationandProgressionDPOutcome>, IUplifter<MessageLearnerDestinationandProgressionDPOutcome>
    {
        private readonly FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _outStartDateProps;
        private readonly FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _outEndDateProps;
        private readonly FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?> _outCollDateProps;

        public LearnerDestinationandProgressionDPOutcomeUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            var modelName = typeof(MessageLearnerDestinationandProgressionDPOutcome).Name;
            Func<DateTime?, DateTime?> standardNullableDateUplifter = ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition;

            _outStartDateProps = new FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "OutStartDate"),
                s => s.OutStartDate,
                standardNullableDateUplifter);

            _outEndDateProps = new FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "OutEndDate"),
                s => s.OutEndDate,
                standardNullableDateUplifter);

            _outCollDateProps = new FieldUpdateProperties<MessageLearnerDestinationandProgressionDPOutcome, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(modelName, "OutCollDate"),
                s => s.OutCollDate,
                standardNullableDateUplifter);
        }

        public MessageLearnerDestinationandProgressionDPOutcome Process(MessageLearnerDestinationandProgressionDPOutcome model)
        {
            ApplyRule(_outStartDateProps, model);
            ApplyRule(_outEndDateProps, model);
            ApplyRule(_outCollDateProps, model);

            return model;
        }
    }
}
