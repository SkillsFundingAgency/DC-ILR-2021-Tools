using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IConsoleService
    {
        Task ProcessFilesAsync(IFileConversionContext fileConversionContext);
    }
}
