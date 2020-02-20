using ESFA.Common.Set;
using Microsoft.Win32;
using System;
using System.Composition;
using System.Windows;
using Tiny.Framework.Contracts.FlowControl;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the file selection interaction class
    /// </summary>
    /// <seealso cref="ISupportFileSelection" />
    [Shared]
    [Export(typeof(ISupportFileSelection))]
    public sealed class FileSelector :
        ISupportFileSelection
    {
        /// <summary>
        /// Gets or sets the filter.
        /// </summary>
        [Import]
        public ISerializeToFileFilter Filter { get; set; }

        /// <summary>
        /// Gets or sets the UI dispatcher.
        /// </summary>
        [Import]
        public IProvideDispatching Dispatcher { get; set; }

        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <typeparam name="TFilter">The type of file filter.</typeparam>
        /// <param name="operation"></param>
        /// <returns>the selected file name (or nothing)</returns>
        public string GetFileName<TFilter>(TypeOfFileOperation operation)
            where TFilter : class
        {
            var dialog = default(FileDialog);

            Dispatcher.Invoke(() =>
            {
                dialog = operation == TypeOfFileOperation.Open
                  ? new OpenFileDialog()
                  : (FileDialog)new SaveFileDialog();

                ConfigureDialog<TFilter>(dialog);

                dialog.ShowDialog(Application.Current.MainWindow);
            });

            return dialog.FileName;
        }

        /// <summary>
        /// Configures the dialog.
        /// </summary>
        /// <param name="dialog">The dialog.</param>
        internal void ConfigureDialog<TFilter>(FileDialog dialog)
            where TFilter : class
        {
            dialog.Filter = Filter.GetFilter<TFilter>();
            dialog.InitialDirectory = Environment.CurrentDirectory;
        }
    }
}
