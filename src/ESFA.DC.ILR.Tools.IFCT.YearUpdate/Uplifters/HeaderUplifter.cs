using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;
using Loose;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Uplifters
{
    public class HeaderUplifter
        : AbstractUplifter<MessageHeader>, IUplifter<MessageHeader>
    {
        private readonly IUplifter<MessageHeaderCollectionDetails> _collectionDetailsUplifter;
        private readonly IUplifter<MessageHeaderSource> _headerSourceUplifter;

        public HeaderUplifter(
            IUplifter<MessageHeaderCollectionDetails> collectionDetailsUplifter,
            IUplifter<MessageHeaderSource> headerSourceUplifter)
        {
            _collectionDetailsUplifter = collectionDetailsUplifter;
            _headerSourceUplifter = headerSourceUplifter;
        }

        public MessageHeader Uplift(MessageHeader model)
        {
            ApplyChildRule(m => m.CollectionDetails, _collectionDetailsUplifter, model);
            ApplyChildRule(m => m.Source, _headerSourceUplifter, model);

            return model;
        }
    }
}
