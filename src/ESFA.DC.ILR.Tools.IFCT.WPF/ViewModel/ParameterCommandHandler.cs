using System;
using System.Windows.Input;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel
{
    // http://www.mvvmlight.net/ ?????
    public class ParameterCommandHandler : ICommand
    {
        private readonly Action<object> _action;
        private readonly Func<bool> _canExecute;

        public ParameterCommandHandler(Action<object> action, Func<bool> canExecute)
        {
            _action = action;
            _canExecute = canExecute;
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public bool CanExecute(object parameter)
        {
            return _canExecute.Invoke();
        }

        public void Execute(object parameter)
        {
            _action(parameter);
        }
    }
}
