using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IConsoleService
    {
        Task<bool> ProcessFilesAsync(IFileConversionContext fileConversionContext);
    }
}
