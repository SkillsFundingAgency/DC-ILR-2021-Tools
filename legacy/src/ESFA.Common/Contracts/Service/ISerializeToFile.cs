using ESFA.Common.Set;

namespace ESFA.Common.Service
{
    /// <summary>
    /// Interface I Serialize To File
    /// </summary>
    /// <typeparam name="TContentType">the type of file content</typeparam>
    public interface ISerializeToFile<TContentType> 
        where TContentType : class
    {
        /// <summary>
        /// the file exists
        /// </summary>
        /// <param name="file">the path to the file.</param>
        /// <returns>true if the file exists</returns>
        bool Exists(string file);

        /// <summary>
        /// Loads the specified file
        /// </summary>
        /// <param name="file">from the file</param>
        /// <returns>an instance of type T</returns>
        TContentType Load(string file);

        /// <summary>
        /// Saves the specified item
        /// </summary>
        /// <param name="item">the item</param>
        /// <param name="fileName">to the specified file</param>
        /// <param name="desiccationMedia">The desiccation media.</param>
        void Save(TContentType item, string fileName, TypeOfMedia desiccationMedia);
    }
}
