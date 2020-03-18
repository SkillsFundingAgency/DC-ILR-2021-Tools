using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.Serialization;

namespace ESFA.Common.Model
{
    /// <summary>
    /// an clean xml production class
    /// i'm here because i'm used across the board and i don't really 'new' these things...
    /// </summary>
    /// <typeparam name="TContent">The type of the content.</typeparam>
    /// <seealso cref="System.Collections.Generic.List{TContent}" />
    [CollectionDataContract(Namespace = ESFAConstant.ModelItemNamespace)]
    public sealed class CleanList<TContent> :
        ObservableCollection<TContent>
    {
        public CleanList()
        {
        }

        public CleanList(IEnumerable<TContent> newContents) :
            base(newContents)
        {
        }
    }

    // note: a codge class for shonky XML
    [CollectionDataContract(Namespace = "")]
    public sealed class NamelessCleanList<TContent> :
        ObservableCollection<TContent>
    {
        public NamelessCleanList()
        {
        }

        public NamelessCleanList(IEnumerable<TContent> newContents) :
            base(newContents)
        {
        }
    }
}
