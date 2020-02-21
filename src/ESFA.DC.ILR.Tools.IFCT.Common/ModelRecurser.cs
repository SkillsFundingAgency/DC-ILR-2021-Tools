using System;
using System.Collections;
using System.Reflection;
using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Interface;

namespace ESFA.DC.ILR.Tools.IFCT.Common
{
    public class ModelRecurser : IModelRecurser
    {
        private readonly ILifetimeScope _scope;

        public ModelRecurser(ILifetimeScope scope)
        {
            _scope = scope;
        }

        public object RecurseAndProcessModel(object model, Type genericProcessorType)
        {
            if (model == null)
            {
                return null;
            }

            RecurseAndProcessChildProperties(model, genericProcessorType, true);

            return model;
        }

        private void RecurseAndProcessChildProperties(object obj, Type genericProcessorType, bool topLevel = false)
        {
            if (obj == null)
            {
                return;
            }

            Type objType = obj.GetType();

            if (!topLevel)
            {
                // See if we have an interface registered that will process this type
                Type specificType = genericProcessorType.MakeGenericType(new[] { objType });
                if (_scope.IsRegistered(specificType))
                {
                    var instance = _scope.Resolve(specificType);

                    var processMethod = specificType.GetRuntimeMethod("Process", new Type[] { objType });

                    if (processMethod != null)
                    {
                        processMethod.Invoke(instance, new object[] { obj });
                    }
                }
            }

            // Recurse through any collections or classes to see if they also can be processed.
            PropertyInfo[] properties = objType.GetProperties();
            foreach (PropertyInfo property in properties)
            {
                object propValue = property.GetValue(obj, null);
                var elems = propValue as IList;
                if (elems != null)
                {
                    // Collection with items
                    foreach (var item in elems)
                    {
                        RecurseAndProcessChildProperties(item, genericProcessorType);
                    }
                }
                else
                {
                    if (property.PropertyType.Assembly == objType.Assembly)
                    {
                        // Class
                        RecurseAndProcessChildProperties(propValue, genericProcessorType);
                    }
                }
            }
        }
    }
}
