using EasyOPA.Indirect;
using System;

namespace EasyOPA.Provider
{
    /// <summary>
    /// i provide token substitution
    /// </summary>
    public interface IProvideTokenSubstitution :
        IRequireComposing
    {
        /// <summary>
        /// Replaces the tokens in...
        /// </summary>
        /// <param name="thisContent">this Content</param>
        /// <param name="withSecondaryPass">with secondary pass.</param>
        /// <returns>
        /// detokenised content
        /// </returns>
        string ReplaceTokensIn(string thisContent, Func<string, string> withSecondaryPass);
    }
}
