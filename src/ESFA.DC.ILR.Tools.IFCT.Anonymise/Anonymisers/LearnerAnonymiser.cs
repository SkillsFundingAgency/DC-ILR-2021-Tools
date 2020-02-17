﻿using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;
using System;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers
{
    public class LearnerAnonymiser : IAnonymise<Loose.MessageLearner>
    {
        private static int LrnGeneratorCount = 0;
        private static int UlnGeneratorCount = 0;
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

            //Find next valid ULN
            long NewULN = -1;
            while (NewULN < 0)
            {
                NewULN = ULN(++UlnGeneratorCount);
            }

            var logEntry = new AnonymiseLogEntry { FieldName = "LearnRefNumber", OldValue = model.LearnRefNumber, NewValue = $"{++LrnGeneratorCount}" };
            _anonymiseLog.Add(logEntry);
            logEntry = new AnonymiseLogEntry { FieldName = "ULN", OldValue = model.ULN?.ToString(), NewValue = $"{NewULN}" };
            _anonymiseLog.Add(logEntry);

            model.LearnRefNumber = LrnGeneratorCount.ToString(); ;
            model.ULN = NewULN; ;

            model.FamilyName = "Mary Jane";
            model.GivenNames = "Sméth";

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
