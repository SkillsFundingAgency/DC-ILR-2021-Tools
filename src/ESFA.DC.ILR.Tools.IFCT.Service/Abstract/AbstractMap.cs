using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Abstract
{
    public abstract class AbstractMap<TPrevious, TCurrent> : IMap<TPrevious, TCurrent>
    {
        public TCurrent Map(TPrevious model)
        {
            if (model == null)
            {
                return default(TCurrent);
            }

            return MapModel(model);

        }

        protected abstract TCurrent MapModel(TPrevious model);
    }
}
