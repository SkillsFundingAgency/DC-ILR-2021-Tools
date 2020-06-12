using EasyOPA.Composition;
using EasyOPA.Coordinator;
using EasyOPA.Factory;
using EasyOPA.Manager;
using EasyOPA.Model;
using EasyOPA.Service;
using EasyOPA.Set;
using EasyOPA.Utility;
using ESFA.Common.Abstract;
using ESFA.Common.Composition;
using ESFA.Common.Manager;
using ESFA.Common.Service;
using ESFA.Common.Set;
using System;
using System.Composition;
using Tiny.Framework.Contracts;
using Tiny.Framework.Contracts.Message;

namespace EasyOPA.ViewModel
{
    /// <summary>
    /// the main view model
    /// </summary>
    /// <seealso cref="StateViewModelBase" />
    /// <seealso cref="IMainViewModel" />
    [Shared]
    [Export(typeof(IMainViewModel))]
    public sealed class MainViewModel :
        StateViewModelBase,
        IMainViewModel,
        IHandleMessage<IChangeRunModeMessage>

    {
        /// <summary>
        /// Gets or sets the console message (view model).
        /// </summary>
        [Import]
        public IManageConsoleOutput Console { get; set; }

        /// <summary>
        /// Gets or sets the file selector (interactive file selection).
        /// </summary>
        [Import]
        public ISupportFileSelection FileSelector { get; set; }

        /// <summary>
        /// Gets or sets the preparation (manager).
        /// </summary>
        [Import]
        public IManageRunPreparation Prepared { get; set; }

        /// <summary>
        /// Gets or sets the provider (selection manager).
        /// </summary>
        [Import]
        public IManageProviderSelection Providers { get; set; }

        /// <summary>
        /// Gets or sets the rule base (selection manager).
        /// </summary>
        [Import]
        public IManageRulesSelection RuleSet { get; set; }

        /// <summary>
        /// Gets or sets the bulk (operation manager).
        /// </summary>
        [Import]
        public IManageBulkOperations Bulk { get; set; }

        /// <summary>
        /// Gets or sets the context factory.
        /// </summary>
        [Import]
        public ICreateSessionContexts ContextFactory { get; set; }

        /// <summary>
        /// Gets or sets the session factory.
        /// </summary>
        [Import]
        public ICreateSessionConfigurations SessionFactory { get; set; }

        /// <summary>
        /// Gets or sets the rulebase.
        /// </summary>
        [Import]
        public ICoordinateExecutionRuns Rulebase { get; set; }

        /// <summary>
        /// Gets or sets the challenger.
        /// </summary>
        [Import]
        public ISupportInteractiveChallenges Challenge { get; set; }

        /// <summary>
        /// Gets or sets the session monitor.
        /// </summary>
        [Import]
        public IMonitorSessionProgress SessionMonitor { get; set; }

        /// <summary>
        /// Gets or sets the file monitor.
        /// </summary>
        [Import]
        public IMonitorFolderchanges FileMonitor { get; set; }

        /// <summary>
        /// Composition is complete, post construction intialisation.
        /// </summary>
        [OnImportsSatisfied]
        public override void OnCompositionComplete()
        {
            base.OnCompositionComplete();

            ShowConsoleCommand = CommandFactory.Create(ShowConsole, () => true);
            ClearCommand = CommandFactory.Create(Clear, () => true);
            SaveCommand = CommandFactory.Create(Save, () => true);

            PrepareCommand = CommandFactory.Create(ManagePreparation, () => true);
            SelectInputFileCommand = CommandFactory.Create(LoadInputFile, () => Prepared.IsValidSQLInstance);
            LoadInputSourcesCommand = CommandFactory.Create(LoadInputSources, () => true);
            ExportToFileCommand = CommandFactory.Create<int>(ExportToFile, () => true);
            SelectProvidersCommand = CommandFactory.Create(SelectProviders, () => Prepared.IsValid());
            ApplyProvidersFilterCommand = CommandFactory.Create(ApplyFilter, () => true);
            SelectRulesCommand = CommandFactory.Create(SelectRules, () => Prepared.IsValid() && Providers.IsValid());

            RunCommand = CommandFactory.Create(Run, OKToRun);
        }

        /// <summary>
        /// Gets or sets the show console command.
        /// </summary>
        public IRelayCommand ShowConsoleCommand { get; set; }

        /// <summary>
        /// Gets or sets the clear command.
        /// </summary>
        public IRelayCommand ClearCommand { get; set; }

        /// <summary>
        /// Gets or sets the save command.
        /// </summary>
        public IRelayCommand SaveCommand { get; set; }

        /// <summary>
        /// Gets or sets the prepare command.
        /// </summary>
        public IRelayCommand PrepareCommand { get; set; }

        /// <summary>
        /// Gets or sets the select input file command.
        /// </summary>
        public IRelayCommand SelectInputFileCommand { get; set; }

        /// <summary>
        /// Gets or sets the export to file command.
        /// </summary>
        public IRelayCommand ExportToFileCommand { get; set; }

        /// <summary>
        /// Gets or sets the load input sources command.
        /// </summary>
        public IRelayCommand LoadInputSourcesCommand { get; set; }

        /// <summary>
        /// Gets or sets the select rules command.
        /// </summary>
        public IRelayCommand SelectProvidersCommand { get; set; }

        public IRelayCommand ApplyProvidersFilterCommand { get; set; }

        /// <summary>
        /// Gets or sets the select rules command.
        /// </summary>
        public IRelayCommand SelectRulesCommand { get; set; }

        /// <summary>
        /// Gets or sets the run command.
        /// </summary>
        public IRelayCommand RunCommand { get; set; }

        /// <summary>
        /// Shows the console.
        /// </summary>
        public void ShowConsole()
        {
            CurrentState = InteractionState.IsModalViewConsole;
        }

        /// <summary>
        /// Clear, this is the command action to clear the console of historical messages.
        /// </summary>
        public void Clear()
        {
            Console.Clear();
            Emitter.Publish(CommonLocalised.ConsoleDefault);
        }

        /// <summary>
        /// Save, this is the command action to the selected file.
        /// the interaction state will become 'is busy'
        /// </summary>
        public async void Save()
        {
            using (State.BusyScope())
            {
                Emitter.Publish(CommonLocalised.LineDivider);
                Emitter.Publish(CommonLocalised.CommencingSaveFormat, DateTime.Now.AsUKDatetime());
                Emitter.Publish(CommonLocalised.LineDivider);

                await Console.Save(() => FileSelector.GetFileName<IManageConsoleOutput>(TypeOfFileOperation.Save));
            }
        }

        /// <summary>
        /// Manages preparation.
        /// </summary>
        public void ManagePreparation()
        {
            CurrentState = EasyOPAInteractionState.IsModalManagePreparation;
        }

        /// <summary>
        /// Load an input file
        /// the interaction state will become 'is busy'
        /// </summary>
        public async void LoadInputFile()
        {
            using (State.BusyScope())
            {
                Emitter.Publish(CommonLocalised.LineDivider);
                Emitter.Publish(CommonLocalised.CommencingSelectFormat, DateTime.Now.AsUKDatetime());
                Emitter.Publish(CommonLocalised.LineDivider);

                await Bulk.Import(
                    Prepared.SQLInstance,
                    Prepared.DBName,
                    Prepared.DBUser,
                    Prepared.DBPassword,
                    () => FileSelector.GetFileName<IManageRunPreparation>(),
                    x => Challenge.GetResponse(x));
                await Prepared.Refresh();
            }
        }

        /// <summary>
        /// Loads the input sources.
        /// </summary>
        public async void LoadInputSources()
        {
            using (State.BusyScope())
            {
                Emitter.Publish(CommonLocalised.CheckingActiveSQLInstance, DateTime.Now.AsUKDatetime());

                await Prepared.Refresh();
            }
        }

        /// <summary>
        /// Exports to file.
        /// </summary>
        /// <param name="forProvider">For provider.</param>
        public async void ExportToFile(int forProvider)
        {
            using (State.BusyScope())
            {
                Emitter.Publish(Localised.ExportingToFile, DateTime.Now.AsUKDatetime());

                await Bulk.Export(Prepared.SelectedSource, forProvider);
            }
        }

        /// <summary>
        /// sets the interaction state to 'select providers'.
        /// </summary>
        public void SelectProviders()
        {
            CurrentState = EasyOPAInteractionState.IsModalManageProviderSelection;
        }

        public async void ApplyFilter()
        {
            using (State.BusyScope())
            {
                await Providers.ApplyFilter();
            }
        }


        /// <summary>
        /// sets the interaction state to 'select rules'.
        /// </summary>
        public void SelectRules()
        {
            CurrentState = EasyOPAInteractionState.IsModalManageRuleSelection;
        }

        /// <summary>
        /// Ok to run.
        /// </summary>
        /// <returns></returns>
        private bool OKToRun()
        {
            return Prepared.IsValid() && Providers.IsValid() && RuleSet.IsValid();
        }

        /// <summary>
        /// Run, this is the command action for rulebase execution.
        /// the interaction state will become 'is busy'
        /// </summary>
        public async void Run()
        {
            using (State.BusyScope())
            {
                Emitter.Publish(CommonLocalised.LineDivider);
                Emitter.Publish(CommonLocalised.CommencingRunFormat, DateTime.Now.AsUKDatetime());
                Emitter.Publish(CommonLocalised.LineDivider);

                var session = SessionFactory.Create(RuleSet.SelectedRules, Prepared.SelectedSource);

                var context = ContextFactory.Create(
                    Prepared.SQLInstance,
                    Prepared.DBUser,
                    Prepared.DBPassword,
                    Prepared.SelectedSource,
                    Prepared.RunMode,
                    Prepared.UseSourceForResults,
                    Prepared.DepositRulebaseArtefacts,
                    Prepared.SelectedReturnPeriod);

                await Rulebase.Run(session, context, Boolean.Parse(Prepared.SaveResults));
            }
        }

        /// <summary>
        /// Called when [state changed].
        /// </summary>
        protected override void OnStateChanged()
        {
            RunCommand.RaiseCanExecuteChanged();
            SelectProvidersCommand.RaiseCanExecuteChanged();
            SelectRulesCommand.RaiseCanExecuteChanged();
            SelectInputFileCommand.RaiseCanExecuteChanged();
        }

        private const string defaultTitle = "Easy OPA";
        private const string liteTitle = "Easy OPA (lite)";
        private string _applicationTitle = defaultTitle;

        /// <summary>
        /// Gets or sets the state of the interaction.
        /// </summary>
        public string ApplicationTitle
        {
            get { return _applicationTitle; }
            set { SetPropertyValue(ref _applicationTitle, value); }
        }

        public override void RegisterMessageHandler()
        {
            base.RegisterMessageHandler();

            Mediator.Register<IChangeRunModeMessage>(HandleMessage);
        }

        public void HandleMessage(IChangeRunModeMessage message)
        {
            ApplicationTitle = message.Payload == TypeOfRunMode.Full ? defaultTitle : liteTitle;
        }
    }
}
