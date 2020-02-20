// TODO: review - refactor? remove?

//using System;
//using System.Data.SqlClient;
//using System.IO;
//using System.Xml.Linq;

//namespace EasyOPA.Service
//{
//    /// <summary>
//    /// TODO: review this class (export base)
//    /// this is not a 'base' class and shouldn't be suffixed as such..
//    /// in fact i'm not sure what it is doing, or is supposed to do...
//    /// see XDSExporter
//    /// </summary>
//    /// <seealso cref="IExporter" />
//    public class ExportBase : IExporter
//    {
//        public SqlConnection IntrajobCon { get; set; }

//        public void Export(string RulebasePrefix)
//        {
//            string path = $"~/Exports/caseData-{DateTime.UtcNow.ToString("dd-MM-yyyy hh:mm:ss")}.xml";
//            if (!Directory.Exists(path))
//            {
//                Directory.CreateDirectory(path);
//            }

//            var caseData = GetCaseData(RulebasePrefix);

//            if (caseData != null)
//            {
//                caseData.Save(path);
//            }
//            else
//            {
//                //log that no case data returned
//            }
//        }

//        private XDocument GetCaseData(string prefix)
//        {
//            using (SqlConnection con = IntrajobCon)
//            {
//                con.Open();
//                using (SqlCommand cmd = new SqlCommand($"select top 1 CaseData from Rulebase.{prefix}_Cases", con))
//                {
//                    using (SqlDataReader reader = cmd.ExecuteReader())
//                    {
//                        if (reader.HasRows)
//                        {
//                            return XDocument.Load(reader.GetSqlXml(0).ToString());
//                        }
//                        else
//                        {
//                            return null;
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
