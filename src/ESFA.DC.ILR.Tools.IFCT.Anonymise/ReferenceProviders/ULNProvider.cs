using System;
using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.ReferenceProviders
{
    public class ULNProvider : IReferenceProvider<long>
    {
        private readonly IAnonymiseLog _anonymiseLog;
        private readonly Dictionary<long, long> _references = new Dictionary<long, long>(1024);
        private int _ulnGeneratorCount = 0;

        public ULNProvider(IAnonymiseLog anonymiseLog)
        {
            _anonymiseLog = anonymiseLog;

            // special case for 9999999999, should always stay the same, this is a 'not assigned yet' placeholder number, not PII
            _references.Add(9999999999, 9999999999);
        }

        public long ProvideNewReference(long prevValue, bool failIfMissing = false)
        {
            if (_references.TryGetValue(prevValue, out long newValue))
            {
                return newValue;
            }

            if (failIfMissing)
            {
                throw new ApplicationException($"Failed to find existing new learner reference for {prevValue}");
            }

            // Find next valid ULN
            newValue = -1;
            while (newValue < 0)
            {
                newValue = ULN(++_ulnGeneratorCount);
            }

            _references.Add(prevValue, newValue);

            var logEntry = new AnonymiseLogEntry { FieldName = "ULN", OldValue = prevValue.ToString(), NewValue = newValue.ToString() };
            _anonymiseLog.Add(logEntry);

            return newValue;
        }

        public static long ULN(long index)
        {
            index += 90000000;
            string s = index.ToString();
            s = s.PadRight(9, '0');
            long result = 0;
            long multiplier = 10;
            for (int i = 0; i != s.Length; ++i)
            {
                result += multiplier-- * ((int)s[i] - 48);
            }

            long mod11 = result % 11;
            if (mod11 == 0)
            {
                return -1;
            }

            long check = 10 - mod11;
            s += check.ToString();

            return long.Parse(s);
        }
    }
}