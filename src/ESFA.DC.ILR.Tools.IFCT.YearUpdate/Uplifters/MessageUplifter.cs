using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class MessageUplifter
        : AbstractUplifter<Message>, IUplifter<Message>
    {
        private readonly IUplifter<MessageHeader> _headerUplifter;
        private readonly IUplifter<MessageSourceFilesSourceFile> _sourceFilesSourceFileUplifter;
        private readonly IUplifter<MessageLearner> _learnerUplifter;
        private readonly IUplifter<MessageLearnerDestinationandProgression> _learnerDestinationandProgressionUplifter;

        public MessageUplifter(
            IUplifter<MessageHeader> headerUplifter,
            IUplifter<MessageSourceFilesSourceFile> sourceFilesSourceFileUplifter,
            IUplifter<MessageLearner> learnerUplifter,
            IUplifter<MessageLearnerDestinationandProgression> learnerDestinationandProgressionUplifter)
        {
            _headerUplifter = headerUplifter;
            _sourceFilesSourceFileUplifter = sourceFilesSourceFileUplifter;
            _learnerUplifter = learnerUplifter;
            _learnerDestinationandProgressionUplifter = learnerDestinationandProgressionUplifter;
        }

        public Message Uplift(Message model)
        {
            ApplyChildRule(m => m.Header, _headerUplifter, model);
            ApplyGroupChildRule(m => m.SourceFiles, _sourceFilesSourceFileUplifter, model);
            ApplyGroupChildRule(m => m.Learner, _learnerUplifter, model);
            ApplyGroupChildRule(m => m.LearnerDestinationandProgression, _learnerDestinationandProgressionUplifter, model);

            return model;
        }
    }
}
