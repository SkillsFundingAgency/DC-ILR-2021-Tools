using EasyOPA.Abstract;
using System;

namespace EasyOPA.Model
{
    /// <summary>
    /// selectable rule base is a visual model item used in the rule selection manager part.
    /// </summary>
    /// <seealso cref="Model.VisualBindingWrapper{IRulebaseConfiguration}" />
    public sealed class RulebaseWrapper :
        VisualBindingWrapper<IRulebaseConfiguration>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="RulebaseWrapper"/> class.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <param name="updateAction">The update action.</param>
        public RulebaseWrapper(IRulebaseConfiguration source, Action updateAction) :
            base(source, updateAction)
        { }

        /// <summary>
        /// is experimental
        /// </summary>
        private bool _isExperimental;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is experimental.
        /// </summary>
        public bool IsExperimental
        {
            get { return _isExperimental; }
            set { SetPropertyValue(ref _isExperimental, value); }
        }
    }
}
