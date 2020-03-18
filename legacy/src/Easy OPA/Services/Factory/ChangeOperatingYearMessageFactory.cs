using EasyOPA.Model;
using EasyOPA.Set;
using System.Composition;

namespace EasyOPA.Factory
{
    /// <summary>
    /// i create change operating year messages
    /// </summary>
    /// <seealso cref="ICreateUseExperimentalItemsMessages" />
    [Shared]
    [Export(typeof(ICreateChangeOperatingYearMessages))]
    public sealed class ChangeOperatingYearMessageFactory :
        ICreateChangeOperatingYearMessages
    {
        /// <summary>
        /// Creates...
        /// </summary>
        /// <param name="forYear">For year.</param>
        /// <param name="andCollection">and collection.</param>
        /// <returns>
        /// a change operating yer message
        /// </returns>
        public IChangeOperatingYearMessage Create(BatchOperatingYear forYear, TypeOfCollection andCollection)
        {
            return new ChangeOperatingYearMessage
            {
                Payload = new YearCollection
                {
                    Year = forYear,
                    Collection = andCollection
                }
            };
        }
    }
}
