using AutoMapper;
using ESFA.DC.ILR.Tools.IFCT.Service.Abstract;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class MessageMapper : AbstractMap<Loose.Previous.Message, Loose.Message>
    {
        protected override Loose.Message MapModel(Loose.Previous.Message model)
        {
            var mapper = CreateMapper();
            var newModel = mapper.Map<Loose.Message>(model);

            return newModel;
        }

        private IMapper CreateMapper()
        {

            var config = new MapperConfiguration(cfg =>
            {
                //Ensure that all strings are not null and are sanitized to remove stray characters
                cfg.CreateMap<string, string>().ConvertUsing(str => (str ?? "").Sanitize());

                cfg.CreateMap<Loose.Previous.Message, Loose.Message>();
                cfg.CreateMap<Loose.Previous.MessageHeader, Loose.MessageHeader>();
                cfg.CreateMap<Loose.Previous.MessageHeaderCollectionDetails, Loose.MessageHeaderCollectionDetails>();
                cfg.CreateMap<Loose.Previous.MessageHeaderSource, Loose.MessageHeaderSource>();
                cfg.CreateMap<Loose.Previous.MessageSourceFiles, Loose.MessageSourceFiles>();
                cfg.CreateMap<Loose.Previous.MessageSourceFilesSourceFile, Loose.MessageSourceFilesSourceFile>();
                cfg.CreateMap<Loose.Previous.MessageLearningProvider, Loose.MessageLearningProvider>();
                cfg.CreateMap<Loose.Previous.MessageLearner, Loose.MessageLearner>();
                cfg.CreateMap<Loose.Previous.MessageLearnerContactPreference, Loose.MessageLearnerContactPreference>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLLDDandHealthProblem, Loose.MessageLearnerLLDDandHealthProblem>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearnerFAM, Loose.MessageLearnerLearnerFAM>();
                cfg.CreateMap<Loose.Previous.MessageLearnerProviderSpecLearnerMonitoring, Loose.MessageLearnerProviderSpecLearnerMonitoring>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearnerEmploymentStatus, Loose.MessageLearnerLearnerEmploymentStatus>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearnerEmploymentStatusEmploymentStatusMonitoring, Loose.MessageLearnerLearnerEmploymentStatusEmploymentStatusMonitoring>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearnerHE, Loose.MessageLearnerLearnerHE>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearnerHELearnerHEFinancialSupport, Loose.MessageLearnerLearnerHELearnerHEFinancialSupport>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDelivery, Loose.MessageLearnerLearningDelivery>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDeliveryLearningDeliveryFAM, Loose.MessageLearnerLearningDeliveryLearningDeliveryFAM>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement, Loose.MessageLearnerLearningDeliveryLearningDeliveryWorkPlacement>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDeliveryAppFinRecord, Loose.MessageLearnerLearningDeliveryAppFinRecord>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDeliveryProviderSpecDeliveryMonitoring, Loose.MessageLearnerLearningDeliveryProviderSpecDeliveryMonitoring>();
                cfg.CreateMap<Loose.Previous.MessageLearnerLearningDeliveryLearningDeliveryHE, Loose.MessageLearnerLearningDeliveryLearningDeliveryHE>();
                cfg.CreateMap<Loose.Previous.MessageLearnerDestinationandProgression, Loose.MessageLearnerDestinationandProgression>();
                cfg.CreateMap<Loose.Previous.MessageLearnerDestinationandProgressionDPOutcome, Loose.MessageLearnerDestinationandProgressionDPOutcome>();
            });

            return config.CreateMapper();
        }
    }
}
