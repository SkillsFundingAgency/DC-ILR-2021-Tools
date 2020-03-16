using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers
{
    public class LearnerAnonymiser : IAnonymise<Loose.MessageLearner>
    {
        private static int lrnGeneratorCount = 0;
        private static int ulnGeneratorCount = 0;
        private readonly IAnonymiseLog _anonymiseLog;

        public LearnerAnonymiser(IAnonymiseLog anonymiseLog)
        {
            _anonymiseLog = anonymiseLog;
        }

        public MessageLearner Process(MessageLearner model)
        {
            if (model == null)
            {
                return null;
            }

            // Find next valid ULN
            long newULN = -1;
            while (newULN < 0)
            {
                newULN = ULN(++ulnGeneratorCount);
            }

            var logEntry = new AnonymiseLogEntry { FieldName = "LearnRefNumber", OldValue = model.LearnRefNumber, NewValue = $"{++lrnGeneratorCount}" };
            _anonymiseLog.Add(logEntry);
            logEntry = new AnonymiseLogEntry { FieldName = "ULN", OldValue = model.ULN?.ToString(), NewValue = $"{newULN}" };
            _anonymiseLog.Add(logEntry);

            model.LearnRefNumber = lrnGeneratorCount.ToString();
            model.ULN = newULN;

            model.GivenNames = "Mary Jane";
            model.FamilyName = "Sméth";

            model.TelNo = "01215555555";

            model.Email = "myemail@myemail.com";

            model.AddLine1 = ReplaceNotNull(model.AddLine1, "18 Address line road");
            model.AddLine2 = ReplaceNotNull(model.AddLine2, "Address Line 2");
            model.AddLine3 = ReplaceNotNull(model.AddLine3, "Address Line 3");
            model.AddLine4 = ReplaceNotNull(model.AddLine4, "Address Line 4");

            model.NINumber = "LJ000000A";

            return model;
        }

        private static string ReplaceNotNull(string source, string replacement)
        {
            return string.IsNullOrWhiteSpace(source) ? source : replacement;
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
                // result += multiplier-- * (s[i] - '0');
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
