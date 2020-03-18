using System;
using System.Collections.Generic;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Utility
{
    /// <summary>
    /// readon only collection extensions
    /// </summary>
    public static class ReadOnlyCollectionExtension
    {
        /// <summary>
        /// Index of.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="items">The items.</param>
        /// <param name="predicate">The predicate.</param>
        /// <returns>the number of the item in the array or -1</returns>
        public static int IndexOf<T>(this IReadOnlyCollection<T> items, Func<T, bool> predicate)
        {
            It.IsEmpty(items)
                .AsGuard<ArgumentException>(nameof(items));
            It.IsNull(predicate)
                .AsGuard<ArgumentException>(nameof(predicate));

            int retVal = 0;

            foreach (var item in items)
            {
                if (predicate(item))
                {
                    return retVal;
                }

                retVal++;
            }

            return -1;
        }

        /// <summary>
        /// For any item that matches the condition do the action.
        /// </summary>
        /// <typeparam name="T">of type</typeparam>
        /// <param name="list">The list.</param>
        /// <param name="matchCondition">match condition.</param>
        /// <param name="doAction">do action.</param>
        public static void ForAny<T>(this IEnumerable<T> list, Func<T, bool> matchCondition, Action<T> doAction)
        {
            It.IsNull(matchCondition)
                .AsGuard<ArgumentNullException>(nameof(matchCondition));
            It.IsNull(doAction)
                .AsGuard<ArgumentNullException>(nameof(doAction));

            var safeList = list.AsSafeReadOnlyList();
            safeList.ForEach(x =>
            {
                if (matchCondition(x))
                {
                    doAction(x);
                }
            });
        }
    }
}
