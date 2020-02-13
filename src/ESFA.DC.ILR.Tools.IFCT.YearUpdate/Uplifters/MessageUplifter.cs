using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class MessageUplifter
        : AbstractUplifter<Message>, IUplifter<Message>
    {
        public MessageUplifter()
        {
        }

        public Message Process(Message model)
        {
            return model;
        }
    }
}
