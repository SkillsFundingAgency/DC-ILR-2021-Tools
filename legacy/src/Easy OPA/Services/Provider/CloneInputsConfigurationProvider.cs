using EasyOPA.Abstract;
using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Provider
{
    /// <summary>
    /// the clone inputs configuration provider
    /// </summary>
    /// <seealso cref="Abstract.DataMappingConfigurationProviderBase{CloneDataMap}" />
    /// <seealso cref="IProvideCloneInputConfiguration" />
    [Shared]
    [Export(typeof(IProvideCloneInputConfiguration))]
    public sealed class CloneInputsConfigurationProvider :
        DataMappingConfigurationProviderBase<CloneDataMap>,
        IProvideCloneInputConfiguration
    {
        /// <summary>
        /// The configuration filename
        /// </summary>
        protected override string ConfigurationFilename => Asset.GetRunMode().SourceMap; //"indatamapping.cfg";
    }
}