using EasyOPA.Model;
using EasyOPA.Set;
using ESFA.Common.Service;
using ESFA.Common.Utility;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Composition;
using System.Linq;
using Tiny.Framework.Abstracts;
using Tiny.Framework.Contracts.FlowControl;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace EasyOPA.Manager
{
    /// <summary>
    /// rule selection manager
    /// visual binding and 'observability' turns a class into a 'component'
    /// </summary>
    /// <seealso cref="ObservableBase" />
    /// <seealso cref="IManageRulesSelection" />
    [Shared]
    [Export(typeof(IManageRulesSelection))]
    public sealed class RuleSelectionManagerPart :
        ObservableBase,
        IManageRulesSelection,
        IHandleMessage<IChangeOperatingYearMessage>,
        IHandleMessage<IChangeRunModeMessage>,
        IHandleMessage<IRulesetConfigurationChangedMessage>
    {
        private IYearCollection _currentYear;

        /// <summary>
        /// Gets or sets the mediator.
        /// </summary>
        [Import]
        public IManageEventPublication Mediator { get; set; }

        [Import]
        public IProvideDispatching Dispatcher { get; set; }

        [Import]
        public ISupportInteractiveChallenges Challenge { get; set; }

        /// <summary>
        /// Gets or sets the asset (manager).
        /// </summary>
        [Import]
        public IManageAssets Asset { get; set; }

        /// <summary>
        /// Composes this instance (on imports satisfied).
        /// </summary>
        [OnImportsSatisfied]
        public void OnCompositionComplete()
        {
            RegisterMessageHandler();
            SetRulesetSelectionMode(Asset.Current);
        }

        /// <summary>
        /// The (underlying rulebase) set
        /// </summary>
        private ICollection<RulebaseWrapper> _ruleSet = Collection.Empty<RulebaseWrapper>();

        /// <summary>
        /// The candidate rules
        /// </summary>
        private ObservableCollection<RulebaseWrapper> _candidateRules;

        /// <summary>
        /// Gets the candidate rules.
        /// </summary>
        public ObservableCollection<RulebaseWrapper> CandidateRules
        {
            get
            {
                return _candidateRules
                  ?? (_candidateRules = new ObservableCollection<RulebaseWrapper>());
            }
        }

        /// <summary>
        /// select all viable
        /// </summary>
        private bool _selectAllViable;

        /// <summary>
        /// Gets or sets a value indicating whether to [select all viable].
        /// </summary>
        public bool SelectAllViable
        {
            get { return _selectAllViable; }
            set
            {
                if (SetPropertyValue(ref _selectAllViable, value))
                {
                    SetSelectionOnAllViableRules(value);
                }
            }
        }

        /// <summary>
        /// The select all visable
        /// </summary>
        private bool _selectAllVisable = true;

        /// <summary>
        /// Gets or sets a value indicating whether [select all visable].
        /// </summary>
        /// <value>
        ///   <c>true</c> if [select all visable]; otherwise, <c>false</c>.
        /// </value>
        public bool SelectAllVisable
        {
            get => _selectAllVisable;
            set => SetPropertyValue(ref _selectAllVisable, value);
        }

        /// <summary>
        /// The selected rules count
        /// </summary>
        private int _selectedRulesCount;

        /// <summary>
        /// Gets the selected rules count.
        /// </summary>
        public int SelectedRulesCount
        {
            get { return _selectedRulesCount; }
            set { SetPropertyValue(ref _selectedRulesCount, value); }
        }

        /// <summary>
        /// The selected rules count
        /// </summary>
        private string _selectedRuleShortnames;

        /// <summary>
        /// Gets the selected rules count.
        /// </summary>
        public string SelectedRuleShortnames
        {
            get { return _selectedRuleShortnames; }
            set { SetPropertyValue(ref _selectedRuleShortnames, value); }
        }

        /// <summary>
        /// Gets the selected rules.
        /// </summary>
        private IReadOnlyCollection<IRulebaseConfiguration> SelectedRules { get; set; }

        /// <summary>
        /// Gets the selected rules.
        /// </summary>
        IReadOnlyCollection<IRulebaseConfiguration> IManageRulesSelection.SelectedRules => SelectedRules;

        /// <summary>
        /// Returns true if ... is valid.
        /// </summary>
        public bool IsValid()
        {
            return CandidateRules.Any(x => x.IsSelectedForProcessing);
        }

        /// <summary>
        /// Updates the selected count.
        /// </summary>
        public void UpdateSelectedCount()
        {
            SelectedRulesCount = CandidateRules.Count(x => x.IsSelectedForProcessing);
            SelectedRules = CandidateRules.Where(x => x.IsSelectedForProcessing).Select(y => y.Source).AsSafeReadOnlyList();
            SelectedRuleShortnames = string.Join(", ", SelectedRules.Select(x => x.ShortName));

            CandidateRules.ForEach(x => x.IsEnabledForSelection = true);

            // only one rule in lite mode 
            if (!SelectAllVisable && SelectedRulesCount == 1)
            {
                var rule = SelectedRules.First();
                if (It.Has(rule.Dependency))
                {
                    CandidateRules.ForAny(x => x.Source.ShortName.ComparesWith(rule.Dependency), x => x.IsSelectedForProcessing = true);
                }

                CandidateRules.ForAny(x => x.Source.Name != rule.Name, x => x.IsEnabledForSelection = false);
            }

            // this will induce a binding read on the property
            _selectAllViable = SelectAllVisable && (SelectedRulesCount == CandidateRules.Count);
            OnPropertyChanged(nameof(SelectAllViable));
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public void RegisterMessageHandler()
        {
            Mediator.Register<IChangeOperatingYearMessage>(HandleMessage, true);
            Mediator.Register<IRulesetConfigurationChangedMessage>(HandleMessage, true);
            Mediator.Register<IChangeRunModeMessage>(HandleMessage, true);
        }

        /// <summary>
        /// Sets the selection on all viable rules.
        /// </summary>
        /// <param name="isSelected">if set to <c>true</c> [is selected].</param>
        public void SetSelectionOnAllViableRules(bool isSelected)
        {
            CandidateRules.ForEach(rule => rule.IsSelectedForProcessing = isSelected);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IChangeOperatingYearMessage message)
        {
            _currentYear = message.Payload;

            It.IsNull(_currentYear)
                .AsGuard<ArgumentNullException>(nameof(_currentYear));

            UpdateYearCollection();
        }

        /// <summary>
        /// Updates the year collection.
        /// </summary>
        public void UpdateYearCollection()
        {
            // 'disable' any inappropriate rulebases
            CandidateRules.Clear();
            SelectedRules = Collection.EmptyAndReadOnly<IRulebaseConfiguration>();

            _ruleSet
                .Where(x => IsValidForUse(x.Source, _currentYear))
                .ForEach(CandidateRules.Add);

            SetSelectionOnAllViableRules(SelectAllViable);
            UpdateSelectedCount();
        }

        public bool IsValidForUse(IRulebaseConfiguration rulebase, IYearCollection source)
        {
            return rulebase.Collection == source.Collection
                && ((rulebase.OperatingYear == source.Year) || rulebase.OperatingYear == BatchOperatingYear.All);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IRulesetConfigurationChangedMessage message)
        {
            _ruleSet.Clear();

            message.Payload
                .ForEach(x => _ruleSet.Add(new RulebaseWrapper(x, UpdateSelectedCount)));

            if (It.Has(_currentYear))
            {
                UpdateYearCollection();
            }
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IChangeRunModeMessage message)
        {
            SetRulesetSelectionMode(message.Payload);
        }

        /// <summary>
        /// Sets the ruleset selection mode.
        /// </summary>
        /// <param name="selectionMode">The selection mode.</param>
        public void SetRulesetSelectionMode(TypeOfRunMode selectionMode)
        {
            SelectAllVisable = selectionMode == TypeOfRunMode.Full;
            if (!SelectAllVisable && It.Has(_currentYear))
            {
                SetSelectionOnAllViableRules(false);
                UpdateSelectedCount();
            }
        }
    }
}
