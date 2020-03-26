namespace ESFA.DC.ILR.Tools.IFCT.YearUpdate.Interface
{
    public interface IYearUpdateConfiguration
    {
        bool ShouldUpdateDate(string objectName, string propertyName);
    }
}
