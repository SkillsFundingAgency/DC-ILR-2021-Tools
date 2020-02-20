using System;
using System.Composition;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Manager
{
    /// <summary>
    /// the text file manager
    /// </summary>
    /// <seealso cref="IManageTextFiles" />
    [Shared]
    [Export(typeof(IManageTextFiles))]
    public sealed class FileManager :
        IManageTextFiles
    {
        /// <summary>
        /// Loads the specified file (name).
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <returns>
        /// the content of the file as a string
        /// </returns>
        public async Task<string> Load(string fileName)
        {
            return await Task.Run(() =>
            {
                var result = string.Empty;

                using (var stream = File.OpenText(fileName))
                {
                    result = stream.ReadToEnd();
                }

                return result;
            });
        }

        /// <summary>
        /// Saves the specified file (name).
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="content">The (file) content.</param>
        /// <returns></returns>
        public async Task Save(string fileName, string content)
        {
            await Task.Run(() =>
            {
                using (var stream = File.CreateText(fileName))
                {
                    stream.Write(content);
                    stream.Flush();
                }
            });
        }

        /// <summary>
        /// Creates the operating folder.
        /// </summary>
        /// <param name="rootDesktopName">Name of the root desktop.</param>
        /// <param name="otherFolders">The other folders.</param>
        /// <returns>
        /// the name of the operating folder
        /// </returns>
        public async Task<string> CreateOperatingFolder(string rootDesktopName, params string[] otherFolders)
        {
            return await Task.Run(() =>
            {
                var desktop = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
                var rootDesktopPath = Path.Combine(desktop, rootDesktopName);

                if (!Directory.Exists(rootDesktopPath))
                {
                    Directory.CreateDirectory(rootDesktopPath);
                }

                var folders = Collection.Empty<string>();
                folders.Add(rootDesktopPath);
                otherFolders.ForEach(folders.Add);
                folders.Add($"{DateTime.Now:yyyyMMdd-HHmmss}");

                var dumpPath = Path.Combine(folders.ToArray());
                if (Directory.Exists(dumpPath))
                {
                    // note: clean out any old files, but we shouldn't get here as the folder is timestamped...
                    Directory.Delete(dumpPath, true);
                }

                Directory.CreateDirectory(dumpPath);

                return dumpPath;
            });
        }

        /// <summary>
        /// Moves the file.
        /// </summary>
        /// <param name="fromHere">From here.</param>
        /// <param name="toHere">To here.</param>
        /// <returns>the running task</returns>
        public async Task MoveFile(string fromHere, string toHere)
        {
            await Task.Run(() =>
            {
                if (File.Exists(toHere))
                {
                    var fileCount = 1;
                    var toHereCopy = $"{toHere}.{fileCount}";
                    while (File.Exists(toHereCopy))
                    {
                        fileCount++;
                        toHereCopy = $"{toHere}.{fileCount}";
                    }

                    File.Move(toHere, toHereCopy);
                }

                File.Move(fromHere, toHere);
            });
        }
    }
}