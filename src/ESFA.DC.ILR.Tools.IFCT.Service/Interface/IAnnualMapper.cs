using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IAnnualMapper
    {
        Task<bool> MapFileAsync(string source, string target);
    }
}
