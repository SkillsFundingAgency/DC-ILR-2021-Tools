using ESFA.DC.ILR.Tools.IFCT.Abstract;
using ESFA.DC.ILR.Tools.YearUpdate.Interface;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public class YearUpdater : AbstractProcess<Loose.Message>
    {
        private readonly IYearUpdateConfiguration _yearUpdateConfiguration;

        public YearUpdater(IYearUpdateConfiguration yearUpdateConfiguration)
        {
            _yearUpdateConfiguration = yearUpdateConfiguration;
        }

        protected override bool ProcessModel(Loose.Message model)
        {
            /* How to iterate through the classes in the ILR file to update the yearly settings
             * Do we want an interface / class for each model that needs to be altered?
             */

            throw new System.NotImplementedException();
        }
    }
}
