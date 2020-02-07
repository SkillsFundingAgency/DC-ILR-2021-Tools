using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class LearnerDestinationandProgressionUplifter
        : AbstractUplifter<MessageLearnerDestinationandProgression>, IUplifter<MessageLearnerDestinationandProgression>
    {
        private readonly IUplifter<MessageLearnerDestinationandProgressionDPOutcome> _learnerDestinationandProgressionDPOutcomeUplifter;

        public LearnerDestinationandProgressionUplifter(IUplifter<MessageLearnerDestinationandProgressionDPOutcome> learnerDestinationandProgressionDPOutcomeUplifter)
        {
            _learnerDestinationandProgressionDPOutcomeUplifter = learnerDestinationandProgressionDPOutcomeUplifter;
        }

        public MessageLearnerDestinationandProgression Uplift(MessageLearnerDestinationandProgression model)
        {
            ApplyGroupChildRule(m => m.DPOutcome, _learnerDestinationandProgressionDPOutcomeUplifter, model);

            return model;
        }
    }
}
