using System;
using System.ComponentModel;
using System.IO;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using System.Windows.Input;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.ILR.Tools.IFCT.WPF.Views;
using ESFA.DC.Logging.Interfaces;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel
{
    public class MainViewModel : INotifyPropertyChanged
    {
        private const string FilenamePlaceholder = "No file chosen";
        private const string FoldernamePlaceholder = "No folder chosen";

        private readonly ILogger _logger;
        private readonly IConsoleService _consoleService;

        private string _sourceFileName = FilenamePlaceholder;
        private string _targetFolderName = FoldernamePlaceholder;
        private bool _canSelectFileFolder = true;
        private bool _canStartProcessing = false;
        private string _progressIndicator = string.Empty;
        private int _progressCounter = -1;

        public MainViewModel(ILogger logger, IConsoleService consoleService)
        {
            _logger = logger;
            _consoleService = consoleService;

            AboutNavigationCommand = new CommandHandler(() => AboutNavigationAction(), () => true);
            ShowChooseFileDialogCommand = new CommandHandler(() => ShowChooseFileDialogAction(), () => true);
            ShowChooseFolderDialogCommand = new CommandHandler(() => ShowChooseFolderDialogAction(), () => true);
            ProcessFileCommand = new CommandHandler(() => ProcessFileAction(), () => true);
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public ICommand AboutNavigationCommand { get; }

        public ICommand ShowChooseFileDialogCommand { get; }

        public ICommand ShowChooseFolderDialogCommand { get; }

        public ICommand ProcessFileCommand { get; }

        public string SourceFileName
        {
            get => _sourceFileName;
            set
            {
                _sourceFileName = value;
                OnPropertyChanged();
            }
        }

        public string TargetFolderName
        {
            get => _targetFolderName;
            set
            {
                _targetFolderName = value;
                OnPropertyChanged();
            }
        }

        public bool CanSelectFileFolder
        {
            get => _canSelectFileFolder;
            set
            {
                _canSelectFileFolder = value;
                OnPropertyChanged();
            }
        }

        public bool CanStartProcessing
        {
            get => _canStartProcessing;
            set
            {
                _canStartProcessing = value;
                OnPropertyChanged();
            }
        }

        public string ProgressIndicator
        {
            get => _progressIndicator;
            set
            {
                _progressIndicator = value;
                OnPropertyChanged();
            }
        }

        public int ProgressCounter
        {
            get => _progressCounter;
            set
            {
                _progressCounter = value;
                OnPropertyChanged();
            }
        }

        protected void OnPropertyChanged([CallerMemberName] string name = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }

        public static void AboutNavigationAction()
        {
            var aboutWindow = new AboutWindow
            {
                Owner = System.Windows.Application.Current.MainWindow
            };

            aboutWindow.ShowDialog();
        }

        public void ShowChooseFileDialogAction()
        {
            var fileName = GetFileNameFromOpenFileDialog();

            if (!string.IsNullOrWhiteSpace(fileName) && fileName != FilenamePlaceholder)
            {
                SourceFileName = fileName;
                CanStartProcessing = File.Exists(SourceFileName) && Directory.Exists(TargetFolderName);
            }
        }

        public void ShowChooseFolderDialogAction()
        {
            var folderName = GetFolderNameFromOpenFolderDialog();

            if (!string.IsNullOrWhiteSpace(folderName) && folderName != FoldernamePlaceholder)
            {
                TargetFolderName = folderName;
                CanStartProcessing = File.Exists(SourceFileName) && Directory.Exists(TargetFolderName);
            }
        }

        public void ProcessFileAction()
        {
            _logger.LogInfo($"Process {SourceFileName} to {TargetFolderName}");
            CanStartProcessing = false;
            CanSelectFileFolder = false;

            var context = new FileConversionContext
            {
                SourceFile = SourceFileName,
                TargetFolder = TargetFolderName,
            };

            try
            {
                using (var worker = new BackgroundWorker())
                {
                    worker.WorkerReportsProgress = true;
                    worker.DoWork += ProcessfilesOnWorker;
                    worker.ProgressChanged += ProgressChangedOnWorker;
                    worker.RunWorkerCompleted += TaskCompletedOnWorker;
                    ProgressIndicator = string.Empty;
                    ProgressCounter = -1;
                    worker.RunWorkerAsync(context);
                }
            }
            catch (Exception)
            {
                CanStartProcessing = true;
                CanSelectFileFolder = true;
            }
        }

        private void ProcessfilesOnWorker(object sender, DoWorkEventArgs e)
        {
            var result = _consoleService.ProcessFilesAsync((FileConversionContext)e.Argument, s =>
            {
                (sender as BackgroundWorker).ReportProgress(0, s);
            }).Result;
        }

        private void ProgressChangedOnWorker(object sender, ProgressChangedEventArgs e)
        {
            ProgressIndicator = (string)e.UserState;
            ProgressCounter++;
        }

        private void TaskCompletedOnWorker(object sender, RunWorkerCompletedEventArgs e)
        {
            CanStartProcessing = true;
            CanSelectFileFolder = true;
        }

        private static string GetFileNameFromOpenFileDialog()
        {
            using (var openFileDialog = new System.Windows.Forms.OpenFileDialog
            {
                CheckFileExists = true,
                Multiselect = false
            })
            {
                var dialogResult = openFileDialog.ShowDialog();
                if (dialogResult == DialogResult.OK)
                {
                    return openFileDialog.FileName;
                }

                return string.Empty;
            }
        }

        private string GetFolderNameFromOpenFolderDialog()
        {
            using (var openFolderDialog = new System.Windows.Forms.FolderBrowserDialog())
            {
                if (!string.IsNullOrEmpty(SourceFileName))
                { // Default to the path of the selected source file.
                    openFolderDialog.SelectedPath = Path.GetDirectoryName(SourceFileName);
                }

                var dialogResult = openFolderDialog.ShowDialog();
                if (dialogResult == DialogResult.OK)
                {
                    return openFolderDialog.SelectedPath;
                }

                return string.Empty;
            }
        }
    }
}
