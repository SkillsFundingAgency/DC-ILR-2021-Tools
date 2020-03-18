using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.Command.Interface
{
    public interface IErrorHandler
    {
        void HandleError(Exception ex);
    }
}
