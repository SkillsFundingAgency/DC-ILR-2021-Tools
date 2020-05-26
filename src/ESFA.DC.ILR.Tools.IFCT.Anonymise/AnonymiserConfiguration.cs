using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Common;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class AnonymiserConfiguration : ConfigurationBase, IAnonymiserConfiguration
    {
        public AnonymiserConfiguration(IConfiguration configuration, ILogger logger)
            : base(configuration, logger)
        {
            LogConfiguration();
        }

        public bool ShouldAnonymise()
        {
            var settingValue = ReadSettingAsString("Anonymisation:Default") ?? "true";
            return bool.TryParse(settingValue, out bool settingParsed) && settingParsed;
        }

        public void LogConfiguration()
        {
            Logger?.LogInfo(GetConfigItemForLog("Anonymisation"));
        }
    }
}