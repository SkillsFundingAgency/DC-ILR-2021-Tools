using ESFA.DC.ILR.Tools.IFCT.Common.Abstract;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.ILR.Tools.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public class YearUpdater : AbstractProcess<Loose.Message>
    {
        private readonly IYearUpdateConfiguration _yearUpdateConfiguration;
        private readonly IUplifter<Message> _messageUplifter;
        private readonly IModelRecurser _modelRecurser;

        public YearUpdater(IYearUpdateConfiguration yearUpdateConfiguration, IUplifter<Message> messageUplifter, IModelRecurser modelRecurser)
        {
            _yearUpdateConfiguration = yearUpdateConfiguration;
            _messageUplifter = messageUplifter;
            _modelRecurser = modelRecurser;
        }

        protected override Message ProcessModel(Message model)
        {
            if (model == null)
            {
                return null;
            }

            _modelRecurser.RecurseAndProcessModel(model, typeof(IUplifter<>));
            return model;
        }
    }
}
