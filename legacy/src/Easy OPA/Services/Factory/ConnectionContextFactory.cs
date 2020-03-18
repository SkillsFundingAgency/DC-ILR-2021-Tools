using EasyOPA.Model;
using System.Composition;
using System.Data.SqlClient;

namespace EasyOPA.Factory
{
    /// <summary>
    /// connection context factory
    /// </summary>
    /// <seealso cref="ICreateConnectionContexts" />
    [Shared]
    [Export(typeof(ICreateConnectionContexts))]
    public sealed class ConnectionContextFactory :
        ICreateConnectionContexts
    {
        /// <summary>
        /// Creates a connection context.
        /// </summary>
        /// <param name="usingConnection">using connection.</param>
        /// <returns>
        /// a connection context
        /// </returns>
        public IConnectionContext Create(IConnectionDetail usingConnection)
        {
            return new ConnectionContext
            {
                Connection = new SqlConnection(usingConnection.SQLDetail),
                Detail = usingConnection
            };
        }
    }
}
