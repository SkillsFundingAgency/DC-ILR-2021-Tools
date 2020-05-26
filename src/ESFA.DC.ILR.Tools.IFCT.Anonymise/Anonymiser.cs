using ESFA.DC.ILR.Tools.IFCT.Anonymise.Interface;
using ESFA.DC.ILR.Tools.IFCT.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.Anonymise
{
    public class Anonymiser : IAnonymise<Message>
    {
        private readonly IAnonymiserConfiguration _anonymiserConfiguration;
        private readonly IModelRecurser _modelRecurser;

        public Anonymiser(IAnonymiserConfiguration anonymiserConfiguration, IModelRecurser modelRecurser)
        {
            _anonymiserConfiguration = anonymiserConfiguration;
            _modelRecurser = modelRecurser;
        }

        public Message Process(Message model)
        {
            if (!_anonymiserConfiguration.ShouldAnonymise())
            {
                return model;
            }

            if (model == null)
            {
                return null;
            }

            _modelRecurser.RecurseAndProcessModel(model, typeof(IAnonymise<>));

            return model;
        }
    }
}
