using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise.Anonymisers
{
    public class LearnerDestinationandProgressionAnonymiser : IAnonymise<Loose.MessageLearnerDestinationandProgression>
    {
        private readonly IReferenceProvider<long> _ulnProvider;
        private readonly IReferenceProvider<string> _learnerRefProvider;

        public LearnerDestinationandProgressionAnonymiser(IReferenceProvider<long> ulnProvider, IReferenceProvider<string> learnerRefProvider)
        {
            _ulnProvider = ulnProvider;
            _learnerRefProvider = learnerRefProvider;
        }

        public MessageLearnerDestinationandProgression Process(MessageLearnerDestinationandProgression model)
        {
            model.LearnRefNumber = _learnerRefProvider.ProvideNewReference(model.LearnRefNumber, true);
            if (model.ULN.HasValue)
            {
                model.ULN = _ulnProvider.ProvideNewReference(model.ULN.Value, true);
            }

            return model;
        }
    }
}