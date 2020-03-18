using ESFA.Common.Factory;
using ESFA.Common.Utility;
using System;
using System.Composition;
using Tiny.Framework.Contracts;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Service
{
    [Shared]
    [Export(typeof(IEmitToConsole))]
    public sealed class ConsoleEmitter :
        IEmitToConsole
    {
        /// <summary>
        /// Gets or sets the localised string resource manager.
        /// </summary>
        [Import]
        public IResolveResources Locals { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the console message (factory)
        /// </summary>
        [Import]
        public ICreateConsoleMessages ConsoleMessage { get; set; }

        /// <summary>
        /// Publishes the specified localised format.
        /// </summary>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        public void Publish<TLocalised>(TLocalised localisedFormat, params object[] items)
            where TLocalised : struct, IComparable, IFormattable
        {
            var format = Locals.GetString(localisedFormat);
            Publish(Format.String(format, items));
        }

        /// <summary>
        /// Publishes the specified localised format, indented appropriately.
        /// </summary>
        /// <param name="indentation">The indentation.</param>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        public void Publish<TLocalised>(Indentation indentation, TLocalised localisedFormat, params object[] items)
            where TLocalised : struct, IComparable, IFormattable
        {
            var format = Locals.GetString(localisedFormat);
            Publish("{0}{1}", indentation.AsString(), Format.String(format, items));
        }

        /// <summary>
        /// Publishes the specified localised format, indented appropriately.
        /// </summary>
        /// <param name="indentation">The indentation.</param>
        /// <param name="localisedFormat">The localised format.</param>
        public void Publish(Indentation indentation, string localisedFormat)
        {
            Publish("{0}{1}", indentation.AsString(), localisedFormat);
        }

        /// <summary>
        /// Publishes the specified localised format.
        /// </summary>
        /// <param name="localisedFormat">The localised format.</param>
        /// <param name="items">The items.</param>
        public void Publish(string localisedFormat, params object[] items)
        {
            Publish(Format.String(localisedFormat, items));
        }

        /// <summary>
        /// Publishes the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Publish(string message)
        {
            Mediator.Publish(ConsoleMessage.Create(message));
        }
    }
}