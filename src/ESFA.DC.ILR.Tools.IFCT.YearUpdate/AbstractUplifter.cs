using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class AbstractUplifter<T>
    {
        protected void ApplyCompiledRule<TValue>(Expression<Func<T, TValue>> selector, Func<T, TValue> compiledSelector, Func<TValue, TValue> rule, T entity)
        {
            var inputValue = compiledSelector.Invoke(entity);

            if (inputValue != null)
            {
                var value = rule.Invoke(inputValue);

                var prop = (PropertyInfo)((MemberExpression)selector.Body).Member;
                prop.SetValue(entity, value);
            }
        }
    }
}
