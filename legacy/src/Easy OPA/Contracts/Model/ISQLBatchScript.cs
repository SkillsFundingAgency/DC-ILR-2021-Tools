using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// sql batch script model item contract
    /// </summary>
    public interface ISQLBatchScript
    {
        /// <summary>
        /// Gets the description.
        /// </summary>
        string Description { get; }

        /// <summary>
        /// Gets the type.
        /// </summary>
        TypeOfBatchScript Type { get; }

        /// <summary>
        /// Gets the command.
        /// </summary>
        string Command { get; }
    }
}
