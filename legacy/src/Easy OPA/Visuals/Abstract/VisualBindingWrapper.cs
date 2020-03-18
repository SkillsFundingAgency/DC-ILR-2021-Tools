using EasyOPA.Model;
using System;
using Tiny.Framework.Abstracts;

namespace EasyOPA.Abstract
{
    /// <summary>
    /// an abstract visual element binding class
    /// </summary>
    /// <typeparam name="TSource">The type of source.</typeparam>
    /// <seealso cref="ObservableBase" />
    public abstract class VisualBindingWrapper<TSource> :
        ObservableBase
        where TSource : class, ICanBeSelectedForProcessing
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="VisualBindingWrapper{TSource}"/> class.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <param name="onStateChanged">The on state changed (action).</param>
        protected VisualBindingWrapper(TSource source, Action onStateChanged)
        {
            Source = source;
            IsSelectedForProcessing = Source.IsSelectedForProcessing;
            OnStateChanged = onStateChanged;
        }

        /// <summary>
        /// Gets or sets the identifier.
        /// </summary>
        public TSource Source { get; }

        /// <summary>
        /// Gets or sets the run update.
        /// </summary>
        public Action OnStateChanged { get; }

        /// <summary>
        /// is selected for processing
        /// </summary>
        private bool _isSelectedForProcessing;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected for processing.
        /// </summary>
        public bool IsSelectedForProcessing
        {
            get { return _isSelectedForProcessing; }
            set
            {
                if (SetPropertyValue(ref _isSelectedForProcessing, value))
                {
                    Source.IsSelectedForProcessing = value;
                    OnStateChanged?.Invoke();
                }
            }
        }

        /// <summary>
        /// is selected for processing
        /// </summary>
        private bool _isEnabledForSelection;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected for processing.
        /// </summary>
        public bool IsEnabledForSelection
        {
            get { return _isEnabledForSelection; }
            set
            {
                if (SetPropertyValue(ref _isEnabledForSelection, value))
                {
                    Source.IsSelectedForProcessing ^= _isEnabledForSelection;
                }
            }
        }

        /// <summary>
        /// Sets the selection without propogation.
        /// </summary>
        /// <param name="selectionState">if set to <c>true</c> [selection state].</param>
        public void SetSelectionWithoutPropogation(bool selectionState)
        {
            _isSelectedForProcessing = selectionState;
            Source.IsSelectedForProcessing = selectionState;
            OnPropertyChanged(nameof(IsSelectedForProcessing));
        }

        // note: the following two properties are here to resolve 'listbox item' binding issues
        /// <summary>
        /// is selected
        /// </summary>
        private bool _isSelected;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is selected.
        /// reduced scope to bind and remove general accesibility
        /// </summary>
        internal bool IsSelected
        {
            get { return _isSelected; }
            set { SetPropertyValue(ref _isSelected, value); }
        }

        /// <summary>
        /// is enabled
        /// </summary>
        private bool _isEnabled = true;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is enabled.
        /// reduced scope to bind and remove general accesibility
        /// </summary>
        internal bool IsEnabled
        {
            get { return _isEnabled; }
            set { SetPropertyValue(ref _isEnabled, value); }
        }
    }
}
