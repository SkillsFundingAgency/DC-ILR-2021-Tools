using ESFA.DC.ILR.Tools.IFCT.Common;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class YearUpdateConfiguration : ConfigurationBase, IYearUpdateConfiguration
    {
        public YearUpdateConfiguration(IConfiguration configuration, ILogger logger)
            : base(configuration, logger)
        {
            LogConfiguration();
        }

        public bool ShouldUpdateDate(string objectName, string propertyName)
        {
            var settingValue = ReadSettingAsString($"DateUplift:{objectName}:{propertyName}") ??
                               ReadSettingAsString("DateUplift:Default") ?? "false";

            return bool.TryParse(settingValue, out bool settingParsed) && settingParsed;
        }

        public void LogConfiguration()
        {
            Logger?.LogInfo(GetConfigItemForLog("DateUplift"));
        }
    }
}
