using ESFA.Common;
using ESFA.Common.Model;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Tiny.Framework.Utilities;

namespace EasyOPA.Model
{
    /// <summary>
    /// token substitution map is the instantiation of the xml file "tokensubstitutionmap.cfg"
    /// </summary>
    /// <seealso cref="IMapTokenSubstitutions" />
    [DataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class TokenSubstitutionMap :
        IMapTokenSubstitutions
    {
        /// <summary>
        /// Gets the batches.
        /// </summary>
        [DataMember]
        public CleanList<TokenSubstitute> Substitutions { get; set; }

        /// <summary>
        /// Gets the batches.
        /// </summary>
        IReadOnlyCollection<ITokenSubstitute> IMapTokenSubstitutions.Substitutions => Substitutions.AsSafeReadOnlyList();
    }
}
