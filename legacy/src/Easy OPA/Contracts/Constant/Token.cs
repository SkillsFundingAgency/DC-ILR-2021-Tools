using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using ESFA.Common.Utility;
using System;
using Tiny.Framework.Utilities;

namespace EasyOPA.Constant
{
    /// <summary>
    /// string tokens
    /// </summary>
    public struct Token
    {
        /// <summary>
        /// For namespace
        /// </summary>
        public const string ForNamespace = "${Namespace}";

        /// <summary>
        /// For working folder
        /// </summary>
        public const string ForWorkingFolder = "${WorkingFolder}"; // <= $(WorkingFolder), used in easy wrapper

        /// <summary>
        /// For period start date
        /// </summary>
        public const string ForPeriodStartDate = "${PeriodStartDate}"; // <= to remove static dates from OPA output configs

        /// <summary>
        /// For operating year
        /// </summary>
        public const string ForOperatingYear = "${year}";

        /// <summary>
        /// For return period
        /// </summary>
        public const string ForReturnPeriod = "${returnPeriod}";

        /// <summary>
        /// For source data store
        /// </summary>
        public const string ForSourceDataStore = "${SourceDataStore}";

        /// <summary>
        /// For target data store
        /// </summary>
        public const string ForTargetDataStore = "${TargetDataStore}";

        /// <summary>
        /// secondary pass tokens held in here..
        /// a secondary pass token is a 'system' token that's mapped to a custom token
        /// if the system token changes we only need to re-map it
        /// </summary>
        public struct SecondaryPass
        {
            /// <summary>
            /// For local server
            /// </summary>
            public const string ForLocalServer = "${localServer}";

            /// <summary>
            /// For contract period
            /// </summary>
            public const string ForContractPeriod = "${contractPeriod}";

            /// <summary>
            /// For provider identifier
            /// </summary>
            public const string ForProviderID = "${providerID}";

            public const string FileName = "${fileName}";
        }

        /// <summary>
        /// Does the secondary pass.
        /// </summary>
        /// <param name="onContent">on content.</param>
        /// <param name="withYear">with year.</param>
        /// <param name="andLocalServerName">and Local Server Name.</param>
        /// <returns>
        /// a de-tokenised string
        /// </returns>
        public static string DoSecondaryPass(string onContent, BatchOperatingYear withYear, IConnectionDetail usingConnection, ReturnPeriod returnPeriod, string fileName = "")
        {
            var unsupportedReturnPeriod = onContent.Contains(ForReturnPeriod) && It.IsInRange(returnPeriod, ReturnPeriod.None);
            unsupportedReturnPeriod
                .AsGuard<NotSupportedException, Localised>(Localised.UnsupportedReturnPeriod);

            return onContent
                    .Replace(ForTargetDataStore, usingConnection.Name)
                    .Replace(ForReturnPeriod, $"{returnPeriod}")
                    .Replace(ForOperatingYear, withYear.AsString())
                    .Replace(SecondaryPass.ForLocalServer, usingConnection.Container)
                    .Replace(SecondaryPass.ForContractPeriod, withYear.AsString())
                    .Replace(SecondaryPass.FileName, fileName);
        }

        /// <summary>
        /// Does the secondary pass.
        /// </summary>
        /// <param name="content">The content.</param>
        /// <param name="providerID">The provider identifier.</param>
        /// <returns>a de-tokenised string</returns>
        public static string DoSecondaryPass(string content, int providerID) =>
            content
                .Replace(SecondaryPass.ForProviderID, $"{providerID}");
    }
}
