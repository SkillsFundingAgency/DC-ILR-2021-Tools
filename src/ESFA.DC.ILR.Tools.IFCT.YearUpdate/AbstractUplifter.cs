using System;
using System.Linq.Expressions;
using System.Reflection;

namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate
{
    public class AbstractUplifter<T>
    where T : class
    {
        protected void ApplyRule<TValue>(FieldUpdateProperties<T, TValue> fieldUpdateProperties, T entity)
        {
            if (!fieldUpdateProperties.ShouldUpdateField)
            {
                return;
            }

            var inputValue = fieldUpdateProperties.CompiledSelector.Invoke(entity);

            if (inputValue != null)
            {
                var value = fieldUpdateProperties.UpliftRule.Invoke(inputValue);

                var prop = (PropertyInfo)((MemberExpression)fieldUpdateProperties.Selector.Body).Member;
                prop.SetValue(entity, value);
            }
        }
    }
}
