using System.Data;
using System.Data.SqlClient;
using Tiny.Framework.Utilities;

namespace XML2SQL
{
    public class SQLDatabase
    {
        private const int _timeOut = 900;

        public static SqlConnection Connection { get; private set; }

        public static void Open(string connectionString)
        {
            //Open database connection
            Connection = new SqlConnection(connectionString);
            Connection.Open();
        }

        public static void Close()
        {
            if (Connection.State == ConnectionState.Open)
            {
                Connection.Close();
            }
        }

        public static IDbCommand GetCommand(string statement)
        {
            return new SqlCommand(statement, Connection)
            {
                CommandTimeout = _timeOut
            };
        }

        public static IDataReader ExecuteReader(string statement)
        {
            using (var command = GetCommand(statement))
            {
                return command.ExecuteReader();
            }
        }

        public static TReturnType ExecuteScalar<TReturnType>(string statement)
        {
            using (var command = GetCommand(statement))
            {
                return (TReturnType)command.ExecuteScalar();
            }
        }

        public static void Execute(string statement)
        {
            using (var command = GetCommand(statement))
            {
                command.ExecuteNonQuery();
            }
        }

        public static void DropTable(string tableName)
        {
            SafeActions.Try(() => Execute($"drop table [{tableName}]"));
        }
    }
}
