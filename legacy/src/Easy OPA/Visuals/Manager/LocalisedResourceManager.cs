using EasyOPA.Constant;
using System.Composition;
using System.Resources;
using Tiny.Framework.Contracts;

namespace EasyOPA.Manager
{
    /// <summary>
    /// the localised resource (string) manager
    /// 
    /// you will need one of these in every assembly where you want to expose a set 
    /// of resource strings the common contract usage 'i resolve local resources' is 
    /// used alongside an 'import many' in an aggregated 'group' resource manager
    /// </summary>
    /// <seealso cref="IResolveLocalResources" />
    [Shared]
    [Export(typeof(IResolveLocalResources))]
    public sealed class LocalisedResourceManager : IResolveLocalResources
    {
        private ResourceManager manager = new ResourceManager(EasyOPAConstant.ResourceLocation, typeof(LocalisedResourceManager).Assembly);

        /// <summary>
        /// Gets the string.
        /// </summary>
        /// <param name="usingKey">The using key.</param>
        /// <returns>the resource string</returns>
        public string GetString(string usingKey)
        {
            return manager.GetString(usingKey);
        }

        /// <summary>
        /// Gets the string.
        /// </summary>
        /// <param name="usingKey">The using key.</param>
        /// <returns>the resource string</returns>
        public string GetString(object usingKey)
        {
            return GetString($"{usingKey}");
        }
    }
}
