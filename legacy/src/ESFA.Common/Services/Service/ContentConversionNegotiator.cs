using ESFA.Common.Set;
using System;
using System.Composition;
using Tiny.Framework.Contracts;

namespace ESFA.Common.Service
{
    /// <summary>
    /// Class Content Conversion Negotiator.
    /// </summary>
    /// <seealso cref="INegotiateContentConversion" />
    [Shared]
    [Export(typeof(INegotiateContentConversion))]
    public sealed class ContentConversionNegotiator :
        INegotiateContentConversion
    {
        /// <summary>
        /// Gets or sets the XML converter.
        /// </summary>
        [Import]
        public ISerialiseXMLTypes XmlConverter { get; set; }

        /// <summary>
        /// Gets or sets the j-son converter.
        /// </summary>
        [Import]
        public ISerialiseJsonTypes JsonConverter { get; set; }

        /// <summary>
        /// Gets the type of media conversion required for
        /// </summary>
        /// <param name="thisCandidate">this candidate</param>
        /// <returns>the required media type</returns>
        public static TypeOfMedia GetMediaTypeFor(string thisCandidate)
        {
            if (string.IsNullOrWhiteSpace(thisCandidate))
            {
                throw new ArgumentNullException(nameof(thisCandidate), "content conversion negotiator, get media type for, the candidate cannot be empty");
            }

            // CME: this might be a bit naive
            return thisCandidate.Substring(0, 2).Contains("<") ? TypeOfMedia.XML : TypeOfMedia.JSON;
        }

        /// <summary>
        /// Gets the converter for..
        /// </summary>
        /// <param name="thisMediaType">this media type</param>
        /// <returns>the converter for the required media type</returns>
        public ISerialiseTypes GetConverterFor(TypeOfMedia thisMediaType) => thisMediaType == TypeOfMedia.JSON
            ? (ISerialiseTypes)JsonConverter
            : XmlConverter;

        /// <summary>
        /// Returns a <see cref="string" /> that represents this instance.
        /// to string with no desiccation media defaults to j-son
        /// </summary>
        /// <typeparam name="TDesiccate">The type being desiccated</typeparam>
        /// <param name="item">The item.</param>
        /// <returns>
        /// A <see cref="string" /> that represents this instance.
        /// </returns>
        public string ToString<TDesiccate>(TDesiccate item)
            where TDesiccate : class
        {
            var convert = GetConverterFor(TypeOfMedia.JSON);
            return convert.ToString(item);
        }

        /// <summary>
        /// Returns a <see cref="string" /> that represents this instance.
        /// </summary>
        /// <typeparam name="TDesiccate">The type being desiccated</typeparam>
        /// <param name="item">The item.</param>
        /// <param name="desiccationMedia">The desiccation media.</param>
        /// <returns>
        /// A <see cref="string" /> that represents this instance.
        /// </returns>
        public string ToString<TDesiccate>(TDesiccate item, TypeOfMedia desiccationMedia)
            where TDesiccate : class
        {
            var convert = GetConverterFor(desiccationMedia);
            return convert.ToString(item);
        }

        /// <summary>
        /// From string
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="classType">Type of the class.</param>
        /// <returns>
        /// a re-hydrated class of T
        /// </returns>
        public object FromString(string item, Type classType)
        {
            var convert = GetConverterFor(GetMediaTypeFor(item));
            return convert.FromString(item, classType);
        }

        /// <summary>
        /// converts to type <typeparam name="THydrate">the type of class to hydrate</typeparam> from the string.
        /// requires UTF-8 encoded strings only
        /// </summary>
        /// <typeparam name="THydrate">The type to hydrate.</typeparam>
        /// <param name="item">The item.</param>
        /// <returns>
        /// a re-hydrated class of <typeparam name="THydrate">the type of class to hydrate</typeparam>
        /// </returns>
        public THydrate FromString<THydrate>(string item)
            where THydrate : class
        {
            var requiredMediaType = GetMediaTypeFor(item);
            var convert = GetConverterFor(requiredMediaType);

            return convert.FromString<THydrate>(item);
        }

        /// <summary>
        /// converts to type <typeparam name="THydrate">the type of class to hydrate</typeparam> from the string and
        /// returns it via a supported contract interface
        /// requires UTF-8 encoded strings only
        /// </summary>
        /// <typeparam name="THydrate">The type to hydrate.</typeparam>
        /// <typeparam name="TContract">The contract type.</typeparam>
        /// <param name="item">The item.</param>
        /// <returns>
        /// the re-hydrated item
        /// </returns>
        public TContract FromString<THydrate, TContract>(string item)
            where THydrate : class, TContract
            where TContract : class
        {
            var requiredMediaType = GetMediaTypeFor(item);
            var convert = GetConverterFor(requiredMediaType);

            return convert.FromString<THydrate>(item);
        }
    }
}
