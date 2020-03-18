using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Indirect
{
    /// <summary>
    /// i prepare storage
    /// </summary>
    public interface IPrepareStorage
    {
        /// <summary>
        /// Prepare...
        /// </summary>
        /// <param name="currentContext">current context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        /// <param name="forceCreation">if set to <c>true</c> [force creation].</param>
        void Prepare(IContainSessionContext currentContext, int forProvider, BatchOperatingYear inYear, bool forceCreation = false);
    }
}
