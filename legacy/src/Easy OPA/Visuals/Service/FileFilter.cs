using EasyOPA.Manager;
using ESFA.Common.Manager;
using ESFA.Common.Service;
using System;
using System.Collections.Generic;
using System.Composition;

namespace EasyOPA.Service
{
    /// <summary>
    /// the test contents file dialog filter
    /// </summary>
    /// <seealso cref="ISerializeToFileFilter" />
    [Shared]
    [Export(typeof(ISerializeToFileFilter))]
    public sealed class FileFilter : ISerializeToFileFilter
    {
        /// <summary>
        /// The _filters
        /// </summary>
        private Dictionary<Type, string> _filters = new Dictionary<Type, string> {
            { typeof(IManageRunPreparation), "ILR File To Load|*.xml" },
            { typeof(IManageConsoleOutput), "File Conversion History|*.txt" }
        };

        /// <summary>
        /// Gets the filter.
        /// </summary>
        /// <typeparam name="TFiltered">the filter type</typeparam>
        /// <returns>
        /// the filter string
        /// </returns>
        public string GetFilter<TFiltered>() where TFiltered : class
        {
            return _filters[typeof(TFiltered)];
        }
    }
}
