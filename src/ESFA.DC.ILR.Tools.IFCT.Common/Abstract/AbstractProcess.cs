using ESFA.DC.ILR.Tools.IFCT.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Common.Abstract
{
    public abstract class AbstractProcess<TCurrent> : IProcess<TCurrent>
    {
        public bool Process(TCurrent model)
        {
            if (model == null)
            {
                return false;
            }

            return ProcessModel(model);
        }

        protected abstract bool ProcessModel(TCurrent model);
    }
}
