using System;
using System.Collections.Generic;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.ReferenceProviders
{
    public class LearnerReferenceProvider : IReferenceProvider<string>
    {
        private readonly IAnonymiseLog _anonymiseLog;
        private readonly Dictionary<string, string> _references = new Dictionary<string, string>(1024);
        private int _lrnGeneratorCount = 0;

        public LearnerReferenceProvider(IAnonymiseLog anonymiseLog)
        {
            _anonymiseLog = anonymiseLog;
        }

        public string ProvideNewReference(string prevValue, bool failIfMissing = false)
        {
            if (_references.TryGetValue(prevValue, out string newValue))
            {
                return newValue;
            }

            if (failIfMissing)
            {
                throw new ApplicationException($"Failed to find existing new learner reference for {prevValue}");
            }

            newValue = $"{++_lrnGeneratorCount}";

            _references.Add(prevValue, newValue);

            var logEntry = new AnonymiseLogEntry { FieldName = "LearnRefNumber", OldValue = prevValue, NewValue = newValue };
            _anonymiseLog.Add(logEntry);

            return newValue;
        }
    }
}