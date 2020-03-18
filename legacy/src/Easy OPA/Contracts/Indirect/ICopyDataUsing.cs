using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Indirect
{
    /// <summary>
    /// i copy data using
    /// </summary>
    public interface ICopyDataUsing
    {
        /// <summary>
        /// Copies...
        /// </summary>
        /// <param name="usingContext">using context.</param>
        /// <param name="inYear">in year.</param>
        void Copy(IContainSessionContext usingContext, BatchOperatingYear inYear);
    }
}
