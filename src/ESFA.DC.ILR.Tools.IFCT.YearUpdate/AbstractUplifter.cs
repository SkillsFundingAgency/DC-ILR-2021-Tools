using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class AbstractUplifter<T>
    {
        protected void ApplyGroupChildRule<TValue>(Expression<Func<T, IEnumerable<TValue>>> selector, IUplifter<TValue> uplifter, T entity)
        {
            var selectorFunc = selector.Compile();

            var inputValueList = selectorFunc.Invoke(entity);

            if (inputValueList != null)
            {
                var newValuesList = inputValueList.Select(iv => uplifter.Uplift(iv)).ToList();

                var prop = (PropertyInfo)((MemberExpression)selector.Body).Member;
                prop.SetValue(entity, newValuesList);
            }
        }

        protected void ApplyChildRule<TValue>(Expression<Func<T, TValue>> selector, IUplifter<TValue> uplifter, T entity)
        {
            var selectorFunc = selector.Compile();

            var inputValue = selectorFunc.Invoke(entity);

            if (inputValue != null)
            {
                var value = uplifter.Uplift(inputValue);

                var prop = (PropertyInfo)((MemberExpression)selector.Body).Member;
                prop.SetValue(entity, value);
            }
        }

        protected void ApplyRule<TValue>(Expression<Func<T, TValue>> selector, Func<TValue, TValue> rule, T entity)
        {
            var selectorFunc = selector.Compile();

            var inputValue = selectorFunc.Invoke(entity);

            if (inputValue != null)
            {
                var value = rule.Invoke(inputValue);
                var prop = (PropertyInfo)((MemberExpression)selector.Body).Member;

                prop.SetValue(entity, value);
            }
        }
    }
}
