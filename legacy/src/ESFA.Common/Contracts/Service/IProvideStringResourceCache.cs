using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the string resource cache provider contract
    /// </summary>
    /// <seealso cref="Tiny.Framework.Contracts.FlowControl.IProvideContentMapping{string, string}" />
    public interface IProvideStringResourceCache :
        IProvideContentMapping<string, string>
    {
        /// <summary>
        /// Adds content for the specified key.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <param name="content">The content.</param>
        void Add(string key, string content);
    }
}
