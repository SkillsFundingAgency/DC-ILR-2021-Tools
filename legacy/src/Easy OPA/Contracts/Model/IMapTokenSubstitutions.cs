using System.Collections.Generic;

namespace EasyOPA.Model
{
    /// <summary>
    /// i map token substitutions
    /// </summary>
    public interface IMapTokenSubstitutions
    {
        /// <summary>
        /// Gets the substitutions.
        /// </summary>
        IReadOnlyCollection<ITokenSubstitute> Substitutions { get; }
    }
}
