// TODO: review - refactor? remove?

//using System;
//using System.Collections.Generic;
//using System.IO;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace EasyOPA.Service
//{
//    public class CSVWriter : ICSVWriter
//    {
//        private ICollection<string> _columns = new List<string>();

//        public ICollection<string> Columns
//        {
//            get { return _columns; }
//        }

//        private string _path;
//        public string Path
//        {
//            get
//            {
//                return _path
//                    ?? $"~/Reports/FD/FD_Validation_Report_{DateTime.UtcNow.ToString("dd-MM-yyyy")}.csv";
//            }
//            set
//            {
//                _path = Directory.Exists(value) ? value : null;
//            }
//        }

//        public void AddColumn(string column)
//        {
//            Columns.Add(column);
//        }

//        public void Write(string content, string path)
//        {
//            throw new NotSupportedException();
//        }

//        public void WriteAsync(string content, string path)
//        {
//            throw new NotSupportedException();
//        }

//        public void WriteRow(string row)
//        {
//            rowCheck(row);
//            using (var fs = new FileStream(Path, FileMode.Append))
//            {
//                byte[] rowCont = new UnicodeEncoding().GetBytes(row + "\r\n");
//                fs.Write(rowCont, 0, rowCont.Length);
//            }
//        }

//        public async void WriteRowAsync(string row)
//        {
//            rowCheck(row);
//            using (var fs = new FileStream(Path, FileMode.Append))
//            {
//                byte[] rowCont = new UnicodeEncoding().GetBytes(row + "\r\n");
//                await fs.WriteAsync(rowCont, 0, rowCont.Length);
//            }
//        }

//        private void rowCheck(string row)
//        {
//            string[] items = row.Split(',');

//            if (items.Length != Columns.Count())
//            {
//                throw new InvalidDataException("Row provided does not have the required number of columns");
//            }
//        }

//        public void WriteRows(IEnumerable<string> rows)
//        {
//            int index = 0;

//            try
//            {
//                foreach (string r in rows)
//                {
//                    index++;
//                    WriteRow(r);
//                }
//            }
//            catch (Exception e)
//            {
//                throw new Exception($"Message: {e.Message}\tRowNumber: {index.ToString()}");
//            }
//        }

//        public async void WriteRowsAsync(IEnumerable<string> rows)
//        {
//            Task t = new Task(() =>
//            {
//                WriteRows(rows);
//            });
//            t.Start();
//            await t;
//        }

//        public void WriteHeader()
//        {
//            if (!Directory.Exists(Path))
//            {
//                Directory.CreateDirectory(Path);
//            }

//            using (var fs = new FileStream(Path, FileMode.Create))
//            {
//                StringBuilder headerRow = new StringBuilder();
//                foreach (string headerItem in this.Columns)
//                {
//                    headerRow.Append($"{headerItem}{(headerItem != this.Columns.Last() ? "," : string.Empty)}");
//                }

//                byte[] row = new UnicodeEncoding().GetBytes(headerRow.ToString());
//                fs.Write(row, 0, row.Length);
//            }
//        }
//    }
//}
