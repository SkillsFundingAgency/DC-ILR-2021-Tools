using System;
using Tiny.Framework.Contracts;

namespace ESFA.Common.Model
{
    /// <summary>
    /// the relay command 
    /// </summary>
    /// <seealso cref="IRelayCommand" />
    internal sealed class RelayCommand : IRelayCommand
    {
        /// <summary>
        /// The execute
        /// </summary>
        readonly Action _execute;

        /// <summary>
        /// The can execute
        /// </summary>
        readonly Func<bool> _canExecute;

        /// <summary>
        /// Initializes a new instance of the <see cref="RelayCommand" /> class.
        /// a parameterless constructor for the factory aspect
        /// </summary>
        public RelayCommand() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="RelayCommand" /> class.
        /// </summary>
        /// <param name="execute">The execute.</param>
        public RelayCommand(Action execute) : this(execute, null) { }

        /// <summary>
        /// Initializes a new instance of the <see cref="RelayCommand" /> class.
        /// </summary>
        /// <param name="execute">The execute.</param>
        /// <param name="canExecute">The can execute.</param>
        /// <exception cref="ArgumentNullException">execute</exception>
        public RelayCommand(Action execute, Func<bool> canExecute)
        {
            _execute = execute ?? throw new ArgumentNullException("execute");
            _canExecute = canExecute;
        }

        #region ICommand Members

        /// <summary>
        /// Defines the method that determines whether the command can execute in its current state.
        /// </summary>
        /// <param name="parameter">Data used by the command.  If the command does not require data to be passed, this object can be set to null.</param>
        /// <returns>
        /// true if this command can be executed; otherwise, false.
        /// </returns>
        public bool CanExecute(object parameter)
        {
            return _canExecute == null ? true : _canExecute();
        }

        /// <summary>
        /// Occurs when changes occur that affect whether or not the command should execute.
        /// </summary>
        public event EventHandler CanExecuteChanged;

        /// <summary>
        /// Defines the method to be called when the command is invoked.
        /// </summary>
        /// <param name="parameter">Data used by the command.  If the command does not require data to be passed, this object can be set to null.</param>
        public void Execute(object parameter)
        {
            _execute();
        }

        /// <summary>
        /// Raises the can execute changed.
        /// </summary>
        public void RaiseCanExecuteChanged()
        {
            CanExecuteChanged?.Invoke(this, EventArgs.Empty);
        }

        #endregion // ICommand Members
    }
}
