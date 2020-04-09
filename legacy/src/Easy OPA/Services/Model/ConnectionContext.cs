using ESFA.Common.Service;
using System;
using System.Composition;
using System.Data;
using System.Data.SqlClient;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// connection context (container)
    /// </summary>
    /// <seealso cref="IConnectionContext" />
    public sealed class ConnectionContext :
        IConnectionContext
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets the connection.
        /// </summary>
        public IDbConnection Connection { get; set; }

        /// <summary>
        /// Gets or sets the (associated connections') detail.
        /// </summary>
        public IConnectionDetail Detail { get; set; }

        /// <summary>
        /// Releases unmanaged and - optionally - managed resources.
        /// </summary>
        public void Dispose()
        {
            Connection.Dispose();
        }

        /// <summary>
        /// safely opens the connection.
        /// </summary>
        public void OpenSafe()
        {
            // TODO: review state handling
            // what do we want to do if it's not open and/or cannot be opened
            if (It.IsInRange(Connection.State, ConnectionState.Open))
            {
                return;
            }
            try
            {
                Connection.Open();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
