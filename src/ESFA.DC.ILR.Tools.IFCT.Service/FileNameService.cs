using System;
using System.Globalization;
using System.IO;
using System.Linq;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class FileNameService : IFileNameService
    {
        private const string YEAR_PARSER = "yyyyMMdd";
        private const string SERIAL_DEAFULT = "99";
        private const string DELIMETER = "-";
        private const string FILE_PATH_DELIMETER = @"\";
        private const int ADD_MODIFIER = 1;
        private const int YEAR_LENGTH = 4;
        private const int SERIAL_LENGTH = 2;
        private const int DATESTAMP_LENGTH = 8;
        private const int YEAR_SPLIT_LENGTH = 2;

        public string YearUpdate(string year)
        {
            if (int.TryParse(year, out int a) == false
                || year.Length != YEAR_LENGTH
                || string.IsNullOrWhiteSpace(year))
            {
                throw new ArgumentException("message", nameof(year));
            }

            int yr1 = int.Parse(year.Substring(0, (int)(year.Length / YEAR_SPLIT_LENGTH)), CultureInfo.InvariantCulture);
            int yr2 = int.Parse(year.Substring((int)(year.Length / YEAR_SPLIT_LENGTH), (int)(year.Length / YEAR_SPLIT_LENGTH)), CultureInfo.InvariantCulture);
            yr1 = yr1 + ADD_MODIFIER;
            yr2 = yr2 + ADD_MODIFIER;
            return yr1.ToString(CultureInfo.InvariantCulture) + yr2.ToString(CultureInfo.InvariantCulture);
        }

        public string SerialNumberUpdate(string serialNumber)
        {
            if (int.TryParse(serialNumber, out int x) == false
                || serialNumber.Length != SERIAL_LENGTH
                || string.IsNullOrWhiteSpace(serialNumber))
            {
                throw new ArgumentException("message", nameof(serialNumber));
            }

            return SERIAL_DEAFULT;
        }

        public string DateStampUpdate(string date)
        {
            DateTime dateTime;
            if (DateTime.TryParseExact(date, YEAR_PARSER, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime) == false
                || date.Length != DATESTAMP_LENGTH
                || string.IsNullOrWhiteSpace(date))
            {
                throw new ArgumentException("message", nameof(date));
            }

            dateTime = dateTime.AddYears(ADD_MODIFIER);
            return dateTime.ToString(YEAR_PARSER, CultureInfo.InvariantCulture);
        }

        /// <summary>
        /// Uplifts the ILR name that is given.
        /// Send without the file extension.
        /// </summary>
        /// <param name="currentFileName">Either the XML or ZIP file name.</param>
        /// <returns>Uplifted file name.</returns>
        public string NameGeneration(string currentFileName)
        {
            string[] ilrParts = currentFileName.Split(DELIMETER.ToCharArray()[0]);
            ilrParts[2] = YearUpdate(ilrParts[2]);
            ilrParts[3] = DateStampUpdate(ilrParts[3]);
            ilrParts[5] = SerialNumberUpdate(ilrParts[5]);
            return string.Join(DELIMETER, ilrParts);
        }
    }
}
