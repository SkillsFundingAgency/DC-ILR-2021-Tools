using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface
{
    public interface IAnonymiseLog
    {
        void Add(IAnonymiseLogEntry entry);
        void Clear();
        IList<IAnonymiseLogEntry> Log { get; }
    }
}
