using EasyOPA.Model;
using System;
using System.Threading.Tasks;

namespace EasyOPA.Manager
{
    /// <summary>
    /// i manage bulk operations
    /// </summary>
    public interface IManageBulkOperations
    {
        /// <summary>
        /// Imports the file...
        /// </summary>
        /// <param name="usingInstance">using instance.</param>
        /// <param name="getFileName">get the name of the file</param>
        /// <param name="andConfirmAnyChallenge">and confirm any challenge.</param>
        /// <returns>
        /// the current task
        /// </returns>
        Task Import(string usingInstance, string usingDatabase, string dbUser, string dbPassword, Func<string> getFileName, Func<string, bool> andConfirmAnyChallenge);

        /// <summary>
        /// Exports (the currently selected input source to ILR file).
        /// </summary>
        /// <param name="fromThisSource">From this source.</param>
        /// <param name="forProvider">For provider.</param>
        /// <returns>
        /// the current task
        /// </returns>
        Task Export(IInputDataSource fromThisSource, int forProvider);
    }
}
