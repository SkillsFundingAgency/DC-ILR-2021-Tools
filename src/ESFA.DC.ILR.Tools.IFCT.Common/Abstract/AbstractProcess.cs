using ESFA.DC.ILR.Tools.IFCT.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Common.Abstract
{
    public abstract class AbstractProcess<TCurrent> : IProcess<TCurrent>
    {
        public TCurrent Process(TCurrent model)
        {
            if (model == null)
            {
                return default(TCurrent);
            }

            return ProcessModel(model);
        }

        protected abstract TCurrent ProcessModel(TCurrent model);
    }
}
