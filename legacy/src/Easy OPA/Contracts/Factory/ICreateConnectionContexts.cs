using EasyOPA.Model;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create connection contexts
    /// </summary>
    public interface ICreateConnectionContexts
    {
        /// <summary>
        /// Creates a connection context.
        /// </summary>
        /// <param name="usingConnection">using connection.</param>
        /// <returns>
        /// a connection context
        /// </returns>
        IConnectionContext Create(IConnectionDetail usingConnection);
    }
}
