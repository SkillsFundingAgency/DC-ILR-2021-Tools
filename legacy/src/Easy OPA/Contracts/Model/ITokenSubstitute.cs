namespace EasyOPA.Model
{
    /// <summary>
    /// token substitution model item contract
    /// </summary>
    public interface ITokenSubstitute
    {
        /// <summary>
        /// Gets the token value.
        /// </summary>
        string TokenValue { get; }

        /// <summary>
        /// Gets the substitute.
        /// </summary>
        string Substitute { get; }
    }
}
