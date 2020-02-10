using System.Collections.Generic;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Tests.Abstract
{
    public class TestModelClass
    {
        public virtual string TestProperty { get; set; }

        public virtual TestChildModelClass TestChildClass { get; set; }

        public virtual List<TestChildModelClass> TestChildClassList { get; set; } = new List<TestChildModelClass>();
    }
}
