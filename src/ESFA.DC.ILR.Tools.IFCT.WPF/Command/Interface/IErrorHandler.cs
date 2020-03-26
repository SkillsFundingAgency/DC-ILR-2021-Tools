using System;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.Command.Interface
{
    public interface IErrorHandler
    {
        void HandleError(Exception ex);
    }
}
