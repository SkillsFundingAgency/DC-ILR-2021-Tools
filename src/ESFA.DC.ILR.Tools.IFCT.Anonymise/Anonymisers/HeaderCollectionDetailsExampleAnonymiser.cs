using System;
using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers
{
    public class HeaderCollectionDetailsExampleAnonymiser// : IAnonymise<Loose.MessageHeaderCollectionDetails>
    {
        private readonly IAnonymiseLog _anonymiseLog;

        public HeaderCollectionDetailsExampleAnonymiser(IAnonymiseLog anonymiseLog)
        {
            _anonymiseLog = anonymiseLog;
        }

        public MessageHeaderCollectionDetails Process(MessageHeaderCollectionDetails model)
        {
            if (model == null)
            {
                return null;
            }

            var logEntry = new AnonymiseLogEntry { FieldName = "FilePreparationDate", OldValue = model.FilePreparationDate.ToShortDateString(), NewValue = "01/01/2099" };
            _anonymiseLog.Add(logEntry);

            model.FilePreparationDate = new DateTime(2099, 1, 1);

            return model;
        }
    }
}
