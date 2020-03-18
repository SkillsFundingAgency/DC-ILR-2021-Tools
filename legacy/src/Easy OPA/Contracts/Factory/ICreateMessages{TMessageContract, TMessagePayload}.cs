namespace EasyOPA.Factory
{
    public interface ICreateMessages<TMessageContract, TMessagePayload>
        where TMessageContract : class
        where TMessagePayload : class
    {
        TMessageContract Create(TMessagePayload payload);
    }
}
