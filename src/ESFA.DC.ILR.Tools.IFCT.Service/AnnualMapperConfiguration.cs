using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using Microsoft.Extensions.Configuration;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class AnnualMapperConfiguration : IAnnualMapperConfiguration
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger _logger;

        public AnnualMapperConfiguration(IConfiguration configuration, ILogger logger)
        {
            _configuration = configuration;
            _logger = logger;

            LogConfiguration();
        }

        public bool SanitizeStrings => ReadSettingAsBool("SanitizeStrings", true);

        private bool ReadSettingAsBool(string setting, bool defaultValue)
        {
            var settingValue = _configuration[setting];
            if (bool.TryParse(settingValue, out bool settingParsed))
            {
                return settingParsed;
            }
            return defaultValue;
        }

        public void LogConfiguration()
        {
            _logger.LogInfo(GetConfigItemForLog("SanitizeStrings"));
        }

        private string GetConfigItemForLog(string setting)
        {
            return $"Configuration: {setting}=[{_configuration[setting]}]";
        }
    }
}
