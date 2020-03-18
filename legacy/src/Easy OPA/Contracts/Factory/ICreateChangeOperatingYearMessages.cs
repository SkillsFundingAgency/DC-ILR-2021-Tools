using EasyOPA.Model;
using EasyOPA.Set;

namespace EasyOPA.Factory
{
    /// <summary>
    ///  i create change operating year messages
    /// </summary>
    public interface ICreateChangeOperatingYearMessages
    {
        /// <summary>
        /// Creates...
        /// </summary>
        /// <param name="forYear">For year.</param>
        /// <param name="andCollection">and collection.</param>
        /// <returns>
        /// a change operating yer message
        /// </returns>
        IChangeOperatingYearMessage Create(BatchOperatingYear forYear, TypeOfCollection andCollection);
    }
}
