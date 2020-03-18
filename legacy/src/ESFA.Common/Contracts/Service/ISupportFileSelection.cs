using ESFA.Common.Set;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i support file selection
    /// </summary>
    public interface ISupportFileSelection
    {
        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <typeparam name="TFilter">The type of file filter.</typeparam>
        /// <param name="open">if set to <c>true</c> [open file dialog] <c>false</c> [otherwise it's a save dialog].</param>
        /// <returns></returns>
        string GetFileName<TFilter>(TypeOfFileOperation operation = TypeOfFileOperation.Open)
            where TFilter : class;
    }
}
