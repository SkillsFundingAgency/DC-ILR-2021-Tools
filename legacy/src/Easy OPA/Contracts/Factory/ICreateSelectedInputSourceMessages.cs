using EasyOPA.Model;

namespace EasyOPA.Factory
{
    /// <summary>
    ///  i create input source selected messages
    /// </summary>
    public interface ICreateSelectedInputSourceMessages :
        ICreateMessages<ISelectedInputSourceMessage, IInputDataSource>
    {
    }
}
