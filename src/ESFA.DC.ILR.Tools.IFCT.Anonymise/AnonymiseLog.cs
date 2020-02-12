using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class AnonymiseLog : IAnonymiseLog
    {
        private readonly IList<IAnonymiseLogEntry> log = new List<IAnonymiseLogEntry>();

        public void Add(IAnonymiseLogEntry entry)
        {
            log.Add(entry);
        }

        public IList<IAnonymiseLogEntry> Log => log;
    }
}
