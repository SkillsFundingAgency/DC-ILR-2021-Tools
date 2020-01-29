using System;
using AutoMapper;
using ESFA.DC.ILR.Tools.IFCT.Service.Abstract;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class MessageMapper : AbstractMap<Loose.Previous.Message, Loose.Message>
    {
        private readonly IMapper autoMapper;

        public MessageMapper(IMapperProvider mappingProvider)
        {
            if (mappingProvider == null)
            {
                throw new ArgumentNullException(nameof(mappingProvider));
            }

            autoMapper = mappingProvider.GetMapper();
        }

        protected override Loose.Message MapModel(Loose.Previous.Message model)
        {
            var newModel = autoMapper.Map<Loose.Message>(model);
            return newModel;
        }
    }
}
