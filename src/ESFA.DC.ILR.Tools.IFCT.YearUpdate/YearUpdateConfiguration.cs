using ESFA.DC.ILR.Tools.YearUpdate.Interface;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public class YearUpdateConfiguration : ConfigurationBase, IYearUpdateConfiguration
    {
        public static readonly string AddOneToDatesId = "AddOneToDates";

        public YearUpdateConfiguration(IConfiguration configuration, ILogger logger)
            : base(configuration, logger)
        {
            LogConfiguration();
        }

        public bool AddOneToDates => ReadSettingAsBool(AddOneToDatesId, true);

        public void LogConfiguration()
        {
            Logger.LogInfo(GetConfigItemForLog(AddOneToDatesId));
        }
    }
}
