using System;
using System.Globalization;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class FileNameService : IFileNameService
    {
        private const string YEAR_PARSER = "yyyyMMdd";
        private const string TIME_PARSER = "HHmmss";
        private const string SERIAL_DEFAULT = "99";
        private const char DELIMETER = '-';
        private const int ADD_MODIFIER = 1;
        private const int YEAR_LENGTH = 4;
        private const int SERIAL_LENGTH = 2;
        private const int DATESTAMP_LENGTH = 8;
        private const int TIMESTAMP_LENGTH = 6;
        private const int YEAR_SPLIT_LENGTH = 2;

        public static string YearUpdate(string year)
        {
            if (int.TryParse(year, out _) == false
                || year.Length != YEAR_LENGTH)
            {
                throw new ArgumentException("Year part of ILR filename not valid", nameof(year));
            }

            int yr1 = int.Parse(year.Substring(0, (int)(year.Length / YEAR_SPLIT_LENGTH)), CultureInfo.InvariantCulture);
            int yr2 = int.Parse(year.Substring((int)(year.Length / YEAR_SPLIT_LENGTH), (int)(year.Length / YEAR_SPLIT_LENGTH)), CultureInfo.InvariantCulture);
            yr1 += ADD_MODIFIER;
            yr2 += ADD_MODIFIER;
            return yr1.ToString(CultureInfo.InvariantCulture) + yr2.ToString(CultureInfo.InvariantCulture);
        }

        public static string SerialNumberUpdate(string serialNumber)
        {
            if (!int.TryParse(serialNumber, out _)
                || serialNumber.Length != SERIAL_LENGTH)
            {
                throw new ArgumentException("Serial Number part of ILR filename not valid", nameof(serialNumber));
            }

            return SERIAL_DEFAULT;
        }

        public static string DateStampUpdate(string date)
        {
            if (!DateTime.TryParseExact(date, YEAR_PARSER, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime dateTime)
                || date.Length != DATESTAMP_LENGTH)
            {
                throw new ArgumentException("Date Stamp part of ILR filename not valid", nameof(date));
            }

            dateTime = dateTime.AddYears(ADD_MODIFIER);
            return dateTime.ToString(YEAR_PARSER, CultureInfo.InvariantCulture);
        }

        public static string TimeStampUpdate(string time)
        {
            if (!DateTime.TryParseExact(time, TIME_PARSER, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime dateTime)
                || time.Length != TIMESTAMP_LENGTH)
            {
                throw new ArgumentException("Time Stamp part of ILR filename not valid", nameof(time));
            }

            dateTime = dateTime.AddSeconds(ADD_MODIFIER);
            return dateTime.ToString(TIME_PARSER, CultureInfo.InvariantCulture);
        }

        /// <summary>
        /// Uplifts the ILR name that is given.
        /// Send without the file extension.
        /// </summary>
        /// <param name="currentFileName">Either the XML or ZIP file name.</param>
        /// <returns>Uplifted file name.</returns>
        public string Generate(string currentFileName)
        {
            string[] ilrParts = currentFileName.Split(DELIMETER);

            if (ilrParts.Length != 6)
            {
                throw new ArgumentException("Invalid ILR filename", nameof(currentFileName));
            }

            ilrParts[2] = YearUpdate(ilrParts[2]);
            return string.Join(DELIMETER.ToString(CultureInfo.InvariantCulture), ilrParts);
        }
    }
}
