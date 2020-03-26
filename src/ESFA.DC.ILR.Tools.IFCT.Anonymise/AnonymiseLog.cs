using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class AnonymiseLog : IAnonymiseLog
    {
        private readonly IList<IAnonymiseLogEntry> _log = new List<IAnonymiseLogEntry>();

        public IList<IAnonymiseLogEntry> Log => _log;

        public void Add(IAnonymiseLogEntry entry)
        {
            _log.Add(entry);
        }

        public void Clear()
        {
            _log.Clear();
        }
    }
}
