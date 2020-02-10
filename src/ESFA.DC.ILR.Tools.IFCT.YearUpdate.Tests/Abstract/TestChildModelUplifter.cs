using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Abstract
{
    public class TestChildModelUplifter
        : AbstractUplifter<TestChildModelClass>, IUplifter<TestChildModelClass>
    {
        public TestChildModelClass Uplift(TestChildModelClass model)
        {
            model.ChildTestProperty = model.ChildTestProperty?.ToUpper();
            return model;
        }
    }
}
