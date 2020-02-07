using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Rules
{
    public class RuleProvider : IRuleProvider
    {
        public IRule<T> BuildStandardDateUplifter<T>()
        {
            return new StandardDateUplifterRule<T>();
        }
    }
}
