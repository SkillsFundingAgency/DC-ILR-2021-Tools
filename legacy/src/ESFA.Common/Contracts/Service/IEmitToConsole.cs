using ESFA.Common.Utility;
using System;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i emit console
    /// </summary>
    public interface IEmitToConsole
    {
        /// <summary>
        /// Publishes the specified localised format.
        /// </summary>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        void Publish<TLocalised>(TLocalised localisedFormat, params object[] items)
            where TLocalised : struct, IComparable, IFormattable;

        /// <summary>
        /// Publishes the specified localised format, indented appropriately.
        /// </summary>
        /// <param name="indentation">The indentation.</param>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        void Publish<TLocalised>(Indentation indentation, TLocalised localisedFormat, params object[] items)
            where TLocalised : struct, IComparable, IFormattable;

        /// <summary>
        /// Publishes the specified localised format, indented appropriately.
        /// </summary>
        /// <param name="indentation">The indentation.</param>
        /// <param name="localisedFormat">The localised format.</param>
        void Publish(Indentation indentation, string localisedFormat);

        /// <summary>
        /// Publishes the specified localised format.
        /// </summary>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        void Publish(string localisedFormat, params object[] items);

        /// <summary>
        /// Publishes the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        void Publish(string message);
    }
}
