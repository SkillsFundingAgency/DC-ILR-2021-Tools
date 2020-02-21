using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface
{
    public interface IAnonymiseLog
    {
        IList<IAnonymiseLogEntry> Log { get; }

        void Add(IAnonymiseLogEntry entry);

        void Clear();
    }
}
