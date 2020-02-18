using System;
using System.Collections.Generic;
using System.Text;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IFileNameService
    {
        string Generate(string currentFileName);
    }
}
