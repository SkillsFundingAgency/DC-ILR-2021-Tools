using System;

namespace ESFA.DC.ILR.Tools.IFCT.Interface
{
    public interface IModelRecurser
    {
        object RecurseAndProcessModel(object model, Type genericProcessorType);
    }
}
