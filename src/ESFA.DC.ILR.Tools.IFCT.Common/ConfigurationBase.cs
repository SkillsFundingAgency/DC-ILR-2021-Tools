using Microsoft.Extensions.Configuration;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public abstract class ConfigurationBase
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger _logger;

        public ConfigurationBase(IConfiguration configuration, ILogger logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        protected IConfiguration Configuration => _configuration;

        protected ILogger Logger => _logger;

        protected bool ReadSettingAsBool(string setting, bool defaultValue)
        {
            var settingValue = _configuration[setting];
            if (bool.TryParse(settingValue, out bool settingParsed))
            {
                return settingParsed;
            }

            return defaultValue;
        }

        protected string GetConfigItemForLog(string setting)
        {
            return $"Configuration: {setting}=[{_configuration[setting]}]";
        }
    }
}
