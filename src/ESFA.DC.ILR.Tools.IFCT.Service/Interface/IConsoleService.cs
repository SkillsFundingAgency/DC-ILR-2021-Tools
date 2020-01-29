using System.Threading.Tasks;

namespace ESFA.DC.ILR.Tools.IFCT.Service.Interface
{
    public interface IConsoleService
    {
        Task ProcessFiles(IFileConversionContext fileConversionContext);
    }
}
