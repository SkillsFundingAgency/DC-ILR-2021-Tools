using EasyOPA.Model;
using System.Threading.Tasks;

namespace EasyOPA.Coordinator
{
    /// <summary>
    /// i coordinate (rulebase) execution runs
    /// </summary>
    /// <seealso cref="IRunRequests" />
    public interface ICoordinateExecutionRuns
    {
        /// <summary>
        /// Runs...
        /// </summary>
        /// <param name="usingSession">using session.</param>
        /// <param name="inContext">in context.</param>
        /// <returns>the currently running task</returns>
        Task Run(IContainSessionConfiguration usingSession, IContainSessionContext inContext);
    }
}
