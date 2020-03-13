using EasyOPA.Factory;
using EasyOPA.Model;
using EasyOPA.Properties;
using EasyOPA.Provider;
using EasyOPA.Set;
using ESFA.Common.Manager;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace EasyOPA.Manager
{
    public enum TypeOfProviderListFilter { ID, Address };

    /// <summary>
    /// bulk load manager
    /// visual binding and 'observability' turns a class into a 'component'
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IManageRunPreparation" />
    [Shared]
    [Export(typeof(IManageProviderSelection))]
    public sealed class ProviderManagerPart :
        ObservableBase,
        IHandleMessage<ISelectedInputSourceMessage>,
        IManageProviderSelection
    {
        /// <summary>
        /// list providers trigger
        /// </summary>
        private const int ListFilterTrigger = 10;

        /// <summary>
        /// The filter expressions
        /// </summary>
        private Dictionary<TypeOfProviderListFilter, Func<LearningProviderWrapper, string, bool>> _expressions = new Dictionary<TypeOfProviderListFilter, Func<LearningProviderWrapper, string, bool>>
        {
            [TypeOfProviderListFilter.ID] = (x, y) => $"{x.Source.ID}".EndsWith(y),
            [TypeOfProviderListFilter.Address] = (x, y) => x.Address.Contains(y, StringComparison.OrdinalIgnoreCase),
        };

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
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        /// <summary>
        /// Gets or sets the valid sources (provider).
        /// </summary>
        [Import]
        public IProvideInputDataSources ValidSources { get; set; }

        /// <summary>
        /// Gets or sets the emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Gets or sets the application state manager.
        /// </summary>
        [Import]
        public IManageApplicationState State { get; set; }

        /// <summary>
        /// The providers
        /// </summary>
        private IReadOnlyCollection<LearningProviderWrapper> _providers;

        /// <summary>
        /// Gets or sets the providers.
        /// </summary>
        public IReadOnlyCollection<LearningProviderWrapper> Providers
        {
            get { return _providers; }
            set { SetPropertyValue(ref _providers, value); }
        }

        /// <summary>
        /// select all
        /// </summary>
        private bool _selectAll;

        /// <summary>
        /// Gets or sets a value indicating whether [select all].
        /// </summary>
        public bool SelectAll
        {
            get { return _selectAll; }
            set
            {
                if (SetPropertyValue(ref _selectAll, value))
                {
                    Task.Run(() => SetSelectionOnAllProviders(value));
                }
            }
        }

        /// <summary>
        /// filter by
        /// </summary>
        private TypeOfProviderListFilter _filterBy;

        /// <summary>
        /// Gets or sets the filter by.
        /// </summary>
        public TypeOfProviderListFilter FilterBy
        {
            get { return _filterBy; }
            set { SetPropertyValue(ref _filterBy, value); }
        }

        /// <summary>
        /// filter using
        /// </summary>
        private string _filterUsing;

        /// <summary>
        /// Gets or sets the filter using.
        /// </summary>
        public string FilterUsing
        {
            get { return _filterUsing; }
            set { SetPropertyValue(ref _filterUsing, value); }
        }

        /// <summary>
        /// The filtered providers
        /// </summary>
        private IReadOnlyCollection<LearningProviderWrapper> _filteredProviders;

        /// <summary>
        /// Gets or sets the filtered providers.
        /// </summary>
        public IReadOnlyCollection<LearningProviderWrapper> FilteredProviders
        {
            get { return _filteredProviders; }
            set { SetPropertyValue(ref _filteredProviders, value); }
        }

        /// <summary>
        /// show filter
        /// </summary>
        private bool _showFilter;

        /// <summary>
        /// Gets or sets a value indicating whether [show filter].
        /// </summary>
        public bool ShowFilter
        {
            get { return _showFilter; }
            set { SetPropertyValue(ref _showFilter, value); }
        }
        /// <summary>
        /// The selected providers count
        /// </summary>
        private int _selectedProvidersCount;

        /// <summary>
        /// Gets or sets the selected providers count.
        /// </summary>
        public int SelectedProvidersCount
        {
            get { return _selectedProvidersCount; }
            set { SetPropertyValue(ref _selectedProvidersCount, value); }
        }

        /// <summary>
        /// The selected provider ids
        /// </summary>
        private string _selectedProviderIDs;

        /// <summary>
        /// Gets or sets the selected provider ids.
        /// </summary>
        public string SelectedProviderIDs
        {
            get { return _selectedProviderIDs; }
            set { SetPropertyValue(ref _selectedProviderIDs, value); }
        }

        /// <summary>
        /// Composes this instance (on imports satisfied).
        /// </summary>
        [OnImportsSatisfied]
        public void OnCompositionComplete()
        {
            RegisterMessageHandler();
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public void RegisterMessageHandler()
        {
            Mediator.Register<ISelectedInputSourceMessage>(HandleMessage, true);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(ISelectedInputSourceMessage message)
        {
            Handler.RunAsyncOperation<Localised>(() => RunProviders(message.Payload));
        }

        /// <summary>
        /// Runs (up) the providers.
        /// </summary>
        /// <param name="usingInputSource">using (the) input source.</param>
        /// <returns></returns>
        public async Task RunProviders(IInputDataSource usingInputSource)
        {
            It.IsNull(usingInputSource)
                .AsGuard<ArgumentNullException>(nameof(usingInputSource));

            using (State.BusyScope())
            {
                Emitter.Publish("Loading Providers..");

                await Task.Run(async () =>
                {
                    FilterUsing = string.Empty;
                    Providers = AddProviderDetailsUpdateCountHook(usingInputSource);
                    await ApplyFilter();
                });
            }
        }

        /// <summary>
        /// Applies the filter.
        /// </summary>
        public async Task ApplyFilter()
        {
            Emitter.Publish($"Applying Filter: '{FilterBy}' - '{FilterUsing}'");

            await Task.Run(() =>
            {
                SetSelectionOnAllProviders(false);

                FilteredProviders = It.Has(FilterUsing)
                    ? Providers
                        .Where(x => _expressions[FilterBy](x, FilterUsing))
                        .AsSafeReadOnlyList()
                    : Providers;

                SetSelectionOnAllProviders(true);
            });
        }

        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        public bool IsValid()
        {
            return SelectedProvidersCount > 0;
        }

        /// <summary>
        /// Sets the selection on all providers.
        /// </summary>
        /// <param name="selectAll">if set to <c>true</c> [select all].</param>
        public void SetSelectionOnAllProviders(bool selectAll)
        {
            FilteredProviders.ForEach(x => x.SetSelectionWithoutPropogation(selectAll));
            UpdatePreparationDetails();
        }

        /// <summary>
        /// Updates the preparation details.
        /// </summary>
        public void UpdatePreparationDetails()
        {
            SelectedProvidersCount = Providers.Count(x => x.IsSelectedForProcessing);
            ShowFilter = Providers.Count > ListFilterTrigger;
            SelectedProviderIDs = SelectedProvidersCount > ListFilterTrigger
                ? Resources.TooManyToDisplayText
                : string.Join(", ", Providers.Where(x => x.IsSelectedForProcessing).Select(x => $"{x.Source.ID}"));

            BindingReadSelectAll();
        }

        /// <summary>
        /// Binding read select all.
        /// </summary>
        public void BindingReadSelectAll()
        {
            // this will induce a binding read on the property
            _selectAll = SelectedProvidersCount == FilteredProviders?.Count;
            OnPropertyChanged(nameof(SelectAll));
        }

        /// <summary>
        /// Adds the provider details update count hook.
        /// </summary>
        /// <param name="source">The source.</param>
        public IReadOnlyCollection<LearningProviderWrapper> AddProviderDetailsUpdateCountHook(IInputDataSource source)
        {
            var context = Provider.ConnectionToSource(source.Container, source.Name, source.DBUser, source.DBPassword);
            var providerIDs = source.Providers.Select(x => x.ID).AsSafeReadOnlyList();
            var details = ValidSources.GetProviderDetails(context, providerIDs);

            return source.Providers
                .Select(x =>
                {
                    var count = ValidSources.GetLearnerCount(context, x.ID);
                    var providerDetail = details?.FirstOrDefault(y => y.UKPRN == x.ID);

                    return new LearningProviderWrapper(x, count, providerDetail, UpdatePreparationDetails);
                })
                .AsParallel()
                .AsSafeReadOnlyList();
        }
    }
}
