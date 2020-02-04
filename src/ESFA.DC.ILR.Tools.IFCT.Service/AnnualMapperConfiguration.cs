using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.ILR.Tools.YearUpdate;
using Microsoft.Extensions.Configuration;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class AnnualMapperConfiguration : ConfigurationBase, IAnnualMapperConfiguration
    {
        // TODO - GH Use the Configuration Base class rather than repeat the base code, just where to put it?
        public static readonly string SanitizeStringsId = "SanitizeStrings";

        public AnnualMapperConfiguration(IConfiguration configuration, ILogger logger)
            : base(configuration, logger)
        {
            LogConfiguration();
        }

        public bool SanitizeStrings => ReadSettingAsBool(SanitizeStringsId, true);

        public void LogConfiguration()
        {
            Logger.LogInfo(GetConfigItemForLog(SanitizeStringsId));
        }
    }
}
