using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Indirect
{
    /// <summary>
    /// i clone data using...
    /// </summary>
    public interface ICloneDataUsing
    {
        /// <summary>
        /// Clones...
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="forProvider">for provider.</param>
        /// <param name="inYear">in year.</param>
        void Clone(IContainSessionContext usingContext, int forProvider, BatchOperatingYear inYear);
    }
}
