using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class AnonymiseLog : IAnonymiseLog
    {
        private readonly IList<IAnonymiseLogEntry> log = new List<IAnonymiseLogEntry>();

        public IList<IAnonymiseLogEntry> Log => log;

        public void Add(IAnonymiseLogEntry entry)
        {
            log.Add(entry);
        }

        public void Clear()
        {
            log.Clear();
        }
    }
}
