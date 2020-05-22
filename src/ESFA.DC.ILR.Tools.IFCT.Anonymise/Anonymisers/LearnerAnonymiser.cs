using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers
{
    public class LearnerAnonymiser : IAnonymise<Loose.MessageLearner>
    {
        private readonly IReferenceProvider<long> _ulnProvider;
        private readonly IReferenceProvider<string> _learnerRefProvider;

        public LearnerAnonymiser(IReferenceProvider<long> ulnProvider, IReferenceProvider<string> learnerRefProvider)
        {
            _ulnProvider = ulnProvider;
            _learnerRefProvider = learnerRefProvider;
        }

        public MessageLearner Process(MessageLearner model)
        {
            if (model == null)
            {
                return null;
            }

            model.LearnRefNumber = _learnerRefProvider.ProvideNewReference(model.LearnRefNumber);
            if (model.ULN.HasValue)
            {
                model.ULN = _ulnProvider.ProvideNewReference(model.ULN.Value);
            }

            model.GivenNames = "GivenNames";
            model.FamilyName = "FamilyName";

            model.TelNo = "01215555555";

            model.Email = "myemail@myemail.com";

            model.AddLine1 = "Address line 1";
            model.AddLine2 = "Address Line 2";
            model.AddLine3 = "Address Line 3";
            model.AddLine4 = "Address Line 4";

            model.NINumber = "LJ000000A";

            return model;
        }
    }
}
