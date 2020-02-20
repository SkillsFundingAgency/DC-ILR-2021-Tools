using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Service
{
    /// <summary>
    /// i transform input post validation
    /// </summary>
    public interface ITransformInputPostValidation
    {
        /// <summary>
        /// Transform input...
        /// </summary>
        /// <param name="usingThisContext">using this context.</param>
        /// <param name="forYear">for year.</param>
        void TransformInput(IContainSessionContext usingThisContext, BatchOperatingYear forYear);
    }
}
