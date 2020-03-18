using System.Composition;
using Tiny.Framework.Abstracts;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the string resource cache provider
    /// </summary>
    /// <seealso cref="Tiny.Framework.Abstracts.ContentMapperBase{string, string}" />
    /// <seealso cref="IProvideStringResourceCache" />
    [Shared]
    [Export(typeof(IProvideStringResourceCache))]
    public sealed class StringResourceCacheProvider :
        ContentMapperBase<string, string>,
        IProvideStringResourceCache
    {
        /// <summary>
        /// Gets the default.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns>
        /// <see typeparam="TMappedContent" />
        /// </returns>
        public override string FetchDefault(string key)
        {
            return $"resource no found for key: {key}";
        }
    }
}
