// TODO: review - refactor? remove?

//using System.Collections.Generic;
//using System.Data.SqlClient;
//using System.Linq;
//using System.Text;

//namespace EasyOPA.Service
//{
//    public class ReportFactory : ICreateReports
//    {
//        private IEnumerable<string> _columns;
//        private IEnumerable<string> _rows;
//        private string _report;

//        private void readRows(SqlCommand cmd)
//        {
//            int columns = _columns.Count();

//            if (cmd.Connection.State != System.Data.ConnectionState.Open)
//            {
//                cmd.Connection.Open();
//            }

//            using (SqlDataReader reader = cmd.ExecuteReader())
//            {                
//                if (reader.HasRows)
//                {
//                    while (reader.Read())
//                    {
//                        StringBuilder row = new StringBuilder();
//                        for (int x = 0; x < columns; x++)
//                        {
//                            row.Append(reader.GetValue(x).ToString().Replace(",", "\""));
//                            row.Append(x < (columns - 1) ? "," : "");
//                        }
//                        row.AppendLine();
//                        List<string> rows;
//                        if (_rows == null)
//                        {
//                            rows = new List<string>();
//                        }
//                        else
//                        {
//                            rows = _rows.ToList();
//                        }                        
//                        rows.Add(row.ToString());
//                        _rows = rows;
//                    }
//                }
//            }
//        }

//        private void createReport()
//        {
//            StringBuilder report = new StringBuilder();

//            foreach (var col in _columns)
//            {
//                report.Append(col);
//                if (col != _columns.Last())
//                {
//                    report.Append(",");
//                }
//                else
//                {
//                    report.AppendLine();
//                }
//            }

//            foreach (var row in _rows)
//            {
//                report.AppendLine(row);
//            }

//            _report = report.ToString();
//        }

//        public string Create(IEnumerable<string> columns, IEnumerable<string> rows)
//        {
//            _columns = columns;
//            _rows = rows;
//            createReport();
//            return _report;
//        }

//        public string Create(IEnumerable<string> columns, SqlCommand query)
//        {
//            _columns = columns;
//            readRows(query);
//            createReport();
//            return _report;
//        }
//    }
//}
