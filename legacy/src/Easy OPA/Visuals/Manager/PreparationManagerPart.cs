using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Collections.ObjectModel;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Utilities;

namespace EasyOPA.Manager
{
    /// <summary>
    /// bulk load manager
    /// visual binding and 'observability' turns a class into a 'component'
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IManageRunPreparation" />
    [Shared]
    [Export(typeof(IManageRunPreparation))]
    public sealed class PreparationManagerPart :
        ObservableBase,
        IManageRunPreparation
    {
        /// <summary>
        /// Gets or sets the handler.
        /// </summary>
        [Import]
        public IHandleSafeOperationResponses Handler { get; set; }

        /// <summary>
        /// Gets or sets the provider.
        /// </summary>
        [Import]
        public ICreateSessionContexts Provider { get; set; }

        /// <summary>
        /// Gets or sets the (UI) dispatcher.
        /// </summary>
        [Import]
        public IProvideDispatching Dispatcher { get; set; }

        /// <summary>
        /// Gets or sets the valid sources (provider).
        /// </summary>
        [Import]
        public IProvideInputDataSources ValidSources { get; set; }

        /// <summary>
        /// Gets or sets the message (factory).
        /// </summary>
        [Import]
        public ICreateSelectedInputSourceMessages Message { get; set; }

        /// <summary>
        /// Gets or sets the change year message.
        /// </summary>
        [Import]
        public ICreateChangeOperatingYearMessages ChangeYearMessage { get; set; }

        /// <summary>
        /// Gets or sets the experimental message.
        /// </summary>
        [Import]
        public ICreateUseExperimentalItemsMessages ExperimentalMessage { get; set; }

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the asset (manager).
        /// </summary>
        [Import]
        public IManageAssets Asset { get; set; }

        /// <summary>
        /// The SQL instance
        /// </summary>
        private string _sqlInstance;

        /// <summary>
        /// Gets or sets the SQL instance.
        /// </summary>
        public string SQLInstance
        {
            get
            {
                return _sqlInstance
                    ?? (_sqlInstance = Asset.InstanceName);
            }
            set
            {
                if (SetPropertyValue(ref _sqlInstance, value))
                {
                    Asset.SetInstanceName(value);
                }
            }
        }

        /// <summary>
        /// The run mode
        /// </summary>
        private bool _runMode;

        /// <summary>
        /// Gets a value indicating [run mode].
        /// </summary>
        /// <value>
        /// <c>true</c> if [run mode]; otherwise, <c>false</c>.
        /// </value>
        public bool RunMode
        {
            get => _runMode;
            set
            {
                if (SetPropertyValue(ref _runMode, value))
                {
                    Asset.SetRunMode(value);
                }
            }
        }

        private int? _timeoutInMinutes;

        public int? TimeoutInMinutes
        {
            get
            {
                return _timeoutInMinutes
                    ?? (_timeoutInMinutes = Asset.TimeoutInMinutes);
            }
            set
            {
                if (SetPropertyValue(ref _timeoutInMinutes, value))
                {
                    Asset.SetTimeoutInMinutes((int)value);
                }
            }
        }

        /// <summary>
        /// is valid SQL instance
        /// </summary>
        private bool _isValidSQLInstance;

        /// <summary>
        /// Gets or sets a value indicating whether this instance is valid SQL instance.
        /// </summary>
        public bool IsValidSQLInstance
        {
            get { return _isValidSQLInstance; }
            set { SetPropertyValue(ref _isValidSQLInstance, value); }
        }

        /// <summary>
        /// The candidate sources
        /// </summary>
        private ObservableCollection<IInputDataSource> _candidateSources;

        /// <summary>
        /// Gets the candidate sources.
        /// </summary>
        public ObservableCollection<IInputDataSource> CandidateSources
        {
            get
            {
                return _candidateSources
                  ?? (_candidateSources = new ObservableCollection<IInputDataSource>());
            }
        }

        /// <summary>
        /// The selected source
        /// </summary>
        private IInputDataSource _selectedSource;

        /// <summary>
        /// Gets the selected source.
        /// </summary>
        public IInputDataSource SelectedSource
        {
            get { return _selectedSource; }
            set { SetPropertyValue(ref _selectedSource, value); }
        }

        /// <summary>
        /// use source for results
        /// </summary>
        private bool _useSourceForResults;

        /// <summary>
        /// Gets or sets a value indicating whether [use source for results].
        /// </summary>
        public bool UseSourceForResults
        {
            get { return _useSourceForResults; }
            set { SetPropertyValue(ref _useSourceForResults, value); }
        }

        /// <summary>
        /// use experimental items
        /// </summary>
        private bool _useExperimentalItems;

        /// <summary>
        /// Gets or sets a value indicating whether [use experimental items].
        /// </summary>
        public bool UseExperimentalItems
        {
            get { return _useExperimentalItems; }
            set { SetPropertyValue(ref _useExperimentalItems, value); }
        }

        /// <summary>
        /// deposit rulebase artefacts
        /// </summary>
        private bool _depositRulebaseArtefacts;

        /// <summary>
        /// Gets a value indicating whether [deposit rulebase artefacts].
        /// </summary>
        public bool DepositRulebaseArtefacts
        {
            get { return _depositRulebaseArtefacts; }
            set { SetPropertyValue(ref _depositRulebaseArtefacts, value); }
        }

        /// <summary>
        /// The selected return period
        /// </summary>
        private ReturnPeriod _selectedReturnPeriod;

        /// <summary>
        /// Gets or sets the selected return period.
        /// </summary>
        public ReturnPeriod SelectedReturnPeriod
        {
            get { return _selectedReturnPeriod; }
            set { SetPropertyValue(ref _selectedReturnPeriod, value); }
        }

        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        public bool IsValid()
        {
            return It.Has(SQLInstance) && It.Has(SelectedSource);
        }

        /// <summary>
        /// Composes this instance (on imports satisfied).
        /// </summary>
        [OnImportsSatisfied]
        public void OnCompositionComplete()
        {
            Handler.RunAsyncOperation<Localised>(async () =>
            {
                Asset.Compose();
                ValidSources.Compose();

                RunMode = Asset.Current == TypeOfRunMode.Lite;

                await BuildValidSources();
            });
        }

        /// <summary>
        /// Builds the valid sources.
        /// </summary>
        /// <returns></returns>
        public async Task BuildValidSources()
        {
            var master = Provider.ConnectionToMaster(SQLInstance);
            await GetDatabaseList(master);
        }

        /// <summary>
        /// Gets the database list.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <returns>the currently running task</returns>
        public async Task GetDatabaseList(IConnectionDetail context)
        {
            It.IsNull(context)
                .AsGuard<ArgumentNullException>(nameof(context));

            Dispatcher.BeginInvoke(() => IsValidSQLInstance = false);

            CandidateSources.Clear();
            var candidates = await ValidSources.GetCandidates(context);

            // make sure this all happens on the main thread
            Dispatcher.BeginInvoke(() =>
            {
                candidates
                    .OrderBy(x => x.Name)
                    .ForEach(CandidateSources.Add);

                SelectedSource = CandidateSources.FirstOrDefault();
                IsValidSQLInstance = true;
            });
        }

        /// <summary>
        /// Refreshes this instance.
        /// </summary>
        /// <returns>
        /// the current task
        /// </returns>
        public async Task Refresh()
        {
            await Handler.RunAsyncOperation<Localised>(async () =>
            {
                await BuildValidSources();
            });
        }

        /// <summary>
        /// Called when [property changed].
        /// </summary>
        /// <param name="propertyName">Name of the property.</param>
        protected override void OnPropertyChanged(string propertyName)
        {
            base.OnPropertyChanged(propertyName);

            if (propertyName.ComparesWith(nameof(SelectedSource)) && It.Has(SelectedSource))
            {
                Mediator.Publish(ChangeYearMessage.Create(SelectedSource.OperatingYear, SelectedSource.CollectionType));
                Mediator.Publish(Message.Create(SelectedSource));

                // note: multi provider sources cannot send the data back to source. that would be a destructive operation
                if (SelectedSource.IsMultiProviderSource)
                {
                    UseSourceForResults = false;
                }
            }

            if (propertyName.ComparesWith(nameof(UseExperimentalItems)))
            {
                Mediator.Publish(ExperimentalMessage.Create(UseExperimentalItems));
                Mediator.Publish(ChangeYearMessage.Create(SelectedSource.OperatingYear, SelectedSource.CollectionType));
                Mediator.Publish(Message.Create(SelectedSource));
            }
        }
    }
}
