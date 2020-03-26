using ESFA.DC.ILR.Tools.IFCT.Common.Abstract;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class YearUpdater : AbstractProcess<Loose.Message>
    {
        private readonly IYearUpdateConfiguration _yearUpdateConfiguration;
        private readonly IModelRecurser _modelRecurser;

        public YearUpdater(IYearUpdateConfiguration yearUpdateConfiguration, IModelRecurser modelRecurser)
        {
            _yearUpdateConfiguration = yearUpdateConfiguration;
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
