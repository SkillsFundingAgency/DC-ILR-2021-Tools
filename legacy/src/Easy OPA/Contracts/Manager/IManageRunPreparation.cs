using EasyOPA.Model;
using EasyOPA.Set;
using System.Threading.Tasks;

namespace EasyOPA.Manager
{
    /// <summary>
    /// i manage (test) run preparation
    /// </summary>
    public interface IManageRunPreparation
    {
        /// <summary>
        /// Refreshes this instance.
        /// </summary>
        /// <returns>the current task</returns>
        Task Refresh();

        /// <summary>
        /// Gets the SQL instance.
        /// </summary>
        string SQLInstance { get; }

        string DBName { get; }

        string DBUser { get; }

        string DBPassword { get; }

        string SaveResults { get; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is valid SQL instance.
        /// </summary>
        bool IsValidSQLInstance { get; }

        /// <summary>
        /// Gets the selected source.
        /// </summary>
        IInputDataSource SelectedSource { get; }

        /// <summary>
        /// Gets a value indicating whether [use source for results].
        /// </summary>
        bool UseSourceForResults { get; }

        /// <summary>
        /// Gets a value indicating [run mode].
        /// </summary>
        /// <value>
        ///   <c>true</c> if [run mode]; otherwise, <c>false</c>.
        /// </value>
        bool RunMode { get; }

        /// <summary>
        /// Gets a value indicating whether [deposit rulebase artefacts].
        /// </summary>
        bool DepositRulebaseArtefacts { get; }

        /// <summary>
        /// Gets the selected return period.
        /// </summary>
        ReturnPeriod SelectedReturnPeriod { get; }

        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        bool IsValid();
    }
}
