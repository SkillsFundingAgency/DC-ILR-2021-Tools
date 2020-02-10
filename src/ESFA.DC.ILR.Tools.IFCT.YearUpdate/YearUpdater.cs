using ESFA.DC.ILR.Tools.IFCT.Common.Abstract;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public class YearUpdater : AbstractProcess<Loose.Message>
    {
        private readonly IYearUpdateConfiguration _yearUpdateConfiguration;
        private readonly IUplifter<Message> _messageUplifter;

        public YearUpdater(IYearUpdateConfiguration yearUpdateConfiguration, IUplifter<Message> messageUplifter)
        {
            _yearUpdateConfiguration = yearUpdateConfiguration;
            _messageUplifter = messageUplifter;
        }

        protected override Message ProcessModel(Message model)
        {
            if (model == null)
            {
                return null;
            }

            var result = _messageUplifter.Uplift(model);

            return result;
        }
    }
}
