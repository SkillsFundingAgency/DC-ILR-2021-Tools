namespace EasyOPA.Indirect
{
    /// <summary>
    /// i require composing
    /// this contract was developed because the decorator 
    ///     [OnImportsSatisfied] 
    /// sadly, in some cases, seems to work from the top down; which is wrong...
    /// so things used weren't being initialised till after 
    /// they were first required...
    /// </summary>
    public interface IRequireComposing
    {
        /// <summary>
        /// Composes this instance.
        /// </summary>
        void Compose();
    }
}
