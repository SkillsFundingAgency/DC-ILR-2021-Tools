using System;
using System.Linq.Expressions;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class FieldUpdateProperties<TClass, TField>
        where TClass : class
    {
        public FieldUpdateProperties(bool shouldUpdateField, Expression<Func<TClass, TField>> selectorFunc, Func<TField, TField> upliftRule)
        {
            ShouldUpdateField = shouldUpdateField;
            Selector = selectorFunc;
            UpliftRule = upliftRule;
            CompiledSelector = selectorFunc.Compile();
        }

        public bool ShouldUpdateField { get; }

        public Expression<Func<TClass, TField>> Selector { get; }

        public Func<TClass, TField> CompiledSelector { get; }

        public Func<TField, TField> UpliftRule { get; }
    }
}
