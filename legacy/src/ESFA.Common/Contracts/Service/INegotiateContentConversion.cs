using ESFA.Common.Set;

namespace ESFA.Common.Service
{
    /// <summary>
    /// i negotiate content conversion
    /// </summary>
    public interface INegotiateContentConversion 
    {
        /// <summary>
        /// Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <typeparam name="TDesiccate">The type being desiccated</typeparam>
        /// <param name="item">The item.</param>
        /// <param name="desiccationMedia">The desiccation media.</param>
        /// <returns>A <see cref="string" /> that represents this instance.</returns>
        string ToString<TDesiccate>(TDesiccate item, TypeOfMedia desiccationMedia)
            where TDesiccate : class;

        /// <summary>
        /// converts to type<typeparam name="THydrate">the type of class to hydrate</typeparam>
        /// from the string and returns it via a supported contract interface requires UTF-8
        /// encoded strings only
        /// </summary>
        /// <typeparam name="THydrate">The type to hydrate.</typeparam>
        /// <typeparam name="TContract">The contract type.</typeparam>
        /// <param name="item">The item.</param>
        /// <returns>the re-hydrated item</returns>
        TContract FromString<THydrate, TContract>(string item)
            where THydrate : class, TContract
            where TContract : class;
    }
}
