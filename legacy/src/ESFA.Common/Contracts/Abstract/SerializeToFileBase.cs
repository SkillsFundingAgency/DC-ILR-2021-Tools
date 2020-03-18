using ESFA.Common.Service;
using ESFA.Common.Set;
using System.Composition;
using System.IO;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Abstract
{
    /// <summary>
    /// the file serialization service base abstract
    /// </summary>
    /// <typeparam name="TFileContent">The type of the file content.</typeparam>
    /// <typeparam name="TFileContract">The type of the file contract.</typeparam>
    /// <seealso cref="ISerializeToFile{TFileContract}" />
    public abstract class SerializeToFileBase<TFileContent, TFileContract> :
        ISerializeToFile<TFileContract>
        where TFileContent : class, TFileContract, new()
        where TFileContract : class
    {
        /// <summary>
        /// Gets or sets the converter.
        /// </summary>
        [Import]
        public INegotiateContentConversion Converter { get; set; }

        /// <summary>
        /// Gets or sets the assets (location provider).
        /// </summary>
        [Import]
        public IProvideAssetLocation Location { get; set; }

        /// <summary>
        /// the file exists
        /// </summary>
        /// <param name="file">the path to the file.</param>
        /// <returns>true if the file exists</returns>
        public bool Exists(string file)
        {
            return It.Has(file) && File.Exists(file);
        }

        /// <summary>
        /// Loads the specified file path.
        /// </summary>
        /// <param name="filePath">The file path.</param>
        /// <returns>TFileContract.</returns>
        public TFileContract Load(string filePath)
        {
            TFileContract item = new TFileContent();

            if (Exists(filePath))
            {
                using (var file = File.OpenText(filePath))
                {
                    var xml = file.ReadToEnd();
                    file.Close();
                    item = Converter.FromString<TFileContent, TFileContract>(xml);
                }
            }

            return item;
        }

        /// <summary>
        /// Saves the specified item.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="desiccationMedia">The desiccation media.</param>
        public void Save(TFileContract item, string fileName, TypeOfMedia desiccationMedia)
        {
            if (It.Has(fileName))
            {
                using (var file = File.CreateText(fileName))
                {
                    file.Write(Converter.ToString(item as TFileContent, desiccationMedia));
                    file.Close();
                }
            }
        }
    }
}
