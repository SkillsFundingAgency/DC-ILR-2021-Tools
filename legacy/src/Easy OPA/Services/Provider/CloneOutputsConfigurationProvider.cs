using EasyOPA.Abstract;
using EasyOPA.Model;
using System.Composition;

namespace EasyOPA.Provider
{
    /// <summary>
    /// the clone outputs configuration provider
    /// </summary>
    /// <seealso cref="Abstract.DataMappingConfigurationProviderBase{ProductionCloneDataMap}" />
    /// <seealso cref="IProvideCloneOutputConfiguration" />
    [Shared]
    [Export(typeof(IProvideCloneOutputConfiguration))]
    public sealed class CloneOutputsConfigurationProvider :
        DataMappingConfigurationProviderBase<ProductionCloneDataMap>,
        IProvideCloneOutputConfiguration
    {
        /// <summary>
        /// The configuration filename
        /// </summary>
        protected override string ConfigurationFilename => Asset.GetRunMode().DestinationMap; //"ILRTableMappings.xml";
    }
}
