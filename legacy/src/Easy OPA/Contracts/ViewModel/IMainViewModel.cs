namespace EasyOPA.ViewModel
{
    /// <summary>
    /// the main view model
    /// </summary>
    public interface IMainViewModel
    {
        /// <summary>
        /// Clears this instance.
        /// executed in the view when initialising.
        /// done as things aren't completely wired up untill the view first shows
        /// </summary>
        void Clear();
    }
}
