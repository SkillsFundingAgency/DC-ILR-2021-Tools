using System;
using System.Data;

namespace EasyOPA.Model
{
    public interface IConnectionDetail
    {
        /// <summary>
        /// Gets the name.
        /// </summary>
        string Name { get; }

        /// <summary>
        /// Gets the container.
        /// </summary>
        string Container { get; }

        /// <summary>
        /// Gets the connection details.
        /// </summary>
        string SQLDetail { get; }

        /// <summary>
        /// Gets the oledb/com detail.
        /// </summary>
        string COMDetail { get; }
    }

    /// <summary>
    /// connection context model item contract
    /// </summary>
    public interface IConnectionContext :
        IDisposable
    {
        /// <summary>
        /// Gets the connection.
        /// </summary>
        IDbConnection Connection { get; }

        /// <summary>
        /// Gets or sets the (associated connections') detail.
        /// </summary>
        IConnectionDetail Detail { get; }

        /// <summary>
        /// Opens the connection.
        /// </summary>
        void OpenSafe();
    }
}
