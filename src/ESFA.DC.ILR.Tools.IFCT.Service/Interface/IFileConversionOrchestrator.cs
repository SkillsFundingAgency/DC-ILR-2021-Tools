using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IFileConversionOrchestrator
    {
        Task<bool> MapFileAsync(string sourceFileReference, string sourceFileContainer, string targetFileContainer);
    }
}
