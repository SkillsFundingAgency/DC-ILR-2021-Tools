using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class FieldUpdateProperties<T, DT>
        where T : class
    {
        public FieldUpdateProperties(bool shouldUpdateField, Expression<Func<T, DT>> selecterFunc, Func<DT, DT> upliftRule)
        {
            ShouldUpdateField = shouldUpdateField;
            Selecter = selecterFunc;
            UpliftRule = upliftRule;
            CompiledSelector = selecterFunc.Compile();
        }

        public bool ShouldUpdateField { get; }

        public Expression<Func<T, DT>> Selecter { get; }

        public Func<T, DT> CompiledSelector { get; }

        public Func<DT, DT> UpliftRule { get; }
    }
}
