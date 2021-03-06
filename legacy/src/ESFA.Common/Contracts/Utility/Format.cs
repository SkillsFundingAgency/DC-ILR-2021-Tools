﻿using System;
using System.Globalization;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// Class Format, performs an invariant culture string formatting
    /// </summary>
    public static class Format
    {
        /// <summary>
        /// Invariant culture format the specified string using the list of items.
        /// </summary>
        /// <param name="format">The format.</param>
        /// <param name="items">The items.</param>
        /// <returns></returns>
        public static string String(string format, params object[] items)
        {
            return string.Format(CultureInfo.InvariantCulture, format, items);
        }

        /// <summary>
        /// Compares (the item) with any candidate.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="anyCandidate">Any candidate.</param>
        /// <returns>true if the item matches any of the candididates</returns>
        /// <exception cref="ArgumentNullException">if there aren't any Candidate(s)</exception>
        public static bool ComparesWith(this string item, params string[] anyCandidate)
        {
            (anyCandidate == null)
                .AsGuard<ArgumentNullException>(nameof(anyCandidate));

            foreach (var candidate in anyCandidate)
            {
                var result = string.Compare(item, candidate, StringComparison.InvariantCultureIgnoreCase) == 0;
                if (result)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Determines whether [contains] [the specified candidate].
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="candidate">The candidate.</param>
        /// <param name="comparision">The comparision.</param>
        /// <returns>
        ///   <c>true</c> if [contains] [the specified candidate]; otherwise, <c>false</c>.
        /// </returns>
        public static bool Contains(this string item, string candidate, StringComparison comparision)
        {
            return item?.IndexOf(candidate, comparision) >= 0;
        }
    }
}
