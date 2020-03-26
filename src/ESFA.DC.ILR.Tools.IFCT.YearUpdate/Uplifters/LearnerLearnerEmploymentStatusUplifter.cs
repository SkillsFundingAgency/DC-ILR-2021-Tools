using System;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerLearnerEmploymentStatusUplifter
        : AbstractUplifter<MessageLearnerLearnerEmploymentStatus>, IUplifter<MessageLearnerLearnerEmploymentStatus>
    {
        private readonly FieldUpdateProperties<MessageLearnerLearnerEmploymentStatus, DateTime?> _dateEmpStatAppProps;

        public LearnerLearnerEmploymentStatusUplifter(IRuleProvider ruleProvider, IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _dateEmpStatAppProps = new FieldUpdateProperties<MessageLearnerLearnerEmploymentStatus, DateTime?>(
                yearUpdateConfiguration.ShouldUpdateDate(typeof(MessageLearnerLearnerEmploymentStatus).Name, "DateEmpStatApp"),
                s => s.DateEmpStatApp,
                ruleProvider.BuildStandardDateUplifter<DateTime?>().Definition);
        }

        public MessageLearnerLearnerEmploymentStatus Process(MessageLearnerLearnerEmploymentStatus model)
        {
            ApplyRule(_dateEmpStatAppProps, model);

            return model;
        }
    }
}
