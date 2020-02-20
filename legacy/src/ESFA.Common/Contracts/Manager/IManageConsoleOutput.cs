using System;
using System.Threading.Tasks;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// i manage console output
    /// </summary>
    public interface IManageConsoleOutput
    {
        /// <summary>
        /// Adds a message.
        /// </summary>
        /// <param name="newMessage">The new message.</param>
        void AddMessage(string newMessage);

        /// <summary>
        /// Clears the console.
        /// </summary>
        void Clear();

        /// <summary>
        /// Saves the output to the specified file.
        /// </summary>
        /// <param name="getFileName">gets the name of the file.</param>
        /// <returns>the running task</returns>
        Task Save(Func<string> getFileName);
    }
}
