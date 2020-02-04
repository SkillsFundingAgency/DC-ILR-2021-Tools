using System;
using System.Collections.Generic;
using System.Text;
using ESFA.DC.Logging.Interfaces;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.YearUpdate
{
    public abstract class ConfigurationBase
    {
        protected readonly IConfiguration _configuration;
        protected readonly ILogger _logger;

        public ConfigurationBase(IConfiguration configuration, ILogger logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

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
