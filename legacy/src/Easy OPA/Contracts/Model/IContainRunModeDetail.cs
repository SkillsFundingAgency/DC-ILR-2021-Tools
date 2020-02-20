using EasyOPA.Set;

namespace EasyOPA.Model
{
    /// <summary>
    /// i run facility
    /// </summary>
    public interface IContainRunModeDetail
    {
        /// <summary>
        /// Gets the name.
        /// </summary>
        TypeOfRunMode Name { get; }

        /// <summary>
        /// Gets the destination map.
        /// </summary>
        string DestinationMap { get; }

        /// <summary>
        /// Gets the rulebase.
        /// </summary>
        string Rulebase { get; }

        /// <summary>
        /// Gets the source map.
        /// </summary>
        string SourceMap { get; }

        /// <summary>
        /// Gets the SQL batch.
        /// </summary>
        string SQLBatch { get; }

        /// <summary>
        /// Gets the token map.
        /// </summary>
        string TokenMap { get; }
    }
}
