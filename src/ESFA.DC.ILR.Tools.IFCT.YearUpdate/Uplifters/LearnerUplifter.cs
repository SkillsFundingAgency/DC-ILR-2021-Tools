using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerUplifter
        : AbstractUplifter<MessageLearner>, IUplifter<MessageLearner>
    {
        private readonly FieldUpdateProperties<MessageLearner, DateTime?> _dateOfBirthProps;

        public LearnerUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _dateOfBirthProps = new FieldUpdateProperties<MessageLearner, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(typeof(MessageLearner).Name, "DateOfBirth"),
                s => s.DateOfBirth,
                ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition);
        }

        public MessageLearner Process(MessageLearner model)
        {
            ApplyRule(_dateOfBirthProps, model);

            return model;
        }
    }
}
