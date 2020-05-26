using ESFA.DC.ILR.Tools.IFCT.Common.Abstract;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class YearUpdater : AbstractProcess<Loose.Message>
    {
        private readonly IModelRecurser _modelRecurser;

        public YearUpdater(IModelRecurser modelRecurser)
        {
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
