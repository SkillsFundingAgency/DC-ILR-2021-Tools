using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Autofac;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Message;
using ESFA.DC.ILR.Tools.IFCT.WPF.Command;
using ESFA.DC.ILR.Tools.IFCT.WPF.Views;
using ESFA.DC.Logging.Interfaces;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using Microsoft.Extensions.Configuration;

namespace ESFA.DC.ILR.Tools.IFCT.WPF.ViewModel
{
    public class MainViewModel : ViewModelBase
    {
        private const string FilenamePlaceholder = "No file chosen";
        private const string FoldernamePlaceholder = "No folder chosen";

        private readonly ILogger _logger;
       
        private CancellationTokenSource _cancellationTokenSource;

        private string _sourceFileName = FilenamePlaceholder;
        private string _targetFolderName = FoldernamePlaceholder;
        private bool _upliftDates = true;
        private bool _canSelectFileFolder = true;
        private bool _canStartProcessing = false;
        private string _progressIndicator = string.Empty;
        private int _progressCounter = -1;

        public MainViewModel(ILogger logger)
        {
            _logger = logger;

            AboutNavigationCommand = new RelayCommand(AboutNavigationAction);
            ShowChooseFileDialogCommand = new RelayCommand(ShowChooseFileDialogAction);
            ShowChooseFolderDialogCommand = new RelayCommand(ShowChooseFolderDialogAction);
            ProcessFileCommand = new AsyncCommand(ProcessFileAction);
        }

        public RelayCommand AboutNavigationCommand { get; }

        public RelayCommand ShowChooseFileDialogCommand { get; }

        public RelayCommand ShowChooseFolderDialogCommand { get; }

        public AsyncCommand ProcessFileCommand { get; }

        public string SourceFileName
        {
            get => _sourceFileName;
            set
            {
                _sourceFileName = value;
                RaisePropertyChanged();
            }
        }

        public string TargetFolderName
        {
            get => _targetFolderName;
            set
            {
                _targetFolderName = value;
                RaisePropertyChanged();
            }
        }

        public bool UpliftDates
        {
            get => _upliftDates;
            set
            {
                _upliftDates = value;
                RaisePropertyChanged();
            }
        }

        public bool CanSelectFileFolder
        {
            get => _canSelectFileFolder;
            set
            {
                _canSelectFileFolder = value;
                RaisePropertyChanged();
            }
        }

        public bool CanStartProcessing
        {
            get => _canStartProcessing;
            set
            {
                _canStartProcessing = value;
                RaisePropertyChanged();
            }
        }

        public string ProgressIndicator
        {
            get => _progressIndicator;
            set
            {
                _progressIndicator = value;
                RaisePropertyChanged();
            }
        }

        public int ProgressCounter
        {
            get => _progressCounter;
            set
            {
                _progressCounter = value;
                RaisePropertyChanged();
            }
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

        public void HandleTaskProgressMessage(TaskProgressMessage taskProgressMessage)
        {
            ProgressIndicator = taskProgressMessage.TaskName;
            ProgressCounter = taskProgressMessage.CurrentTask; ;
        }

        public async Task ProcessFileAction()
        {
            _logger.LogInfo($"Process {SourceFileName} to {TargetFolderName}");
            CanStartProcessing = false;
            CanSelectFileFolder = false;

            // Re-create the Configuration with memory source added for options set from the UI
            var memOptions = new List<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>("DateUplift:Default", UpliftDates ? "true" : "false")
            };

            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appSettings.json");
            configBuilder.AddInMemoryCollection(memOptions);
            IConfiguration config = configBuilder.Build();

            using (var scope = App.Container.BeginLifetimeScope(
                builder => { builder.RegisterInstance<IConfiguration>(config); }))
            {
                var consoleService = scope.Resolve<IConsoleService>();
                var messengerService = scope.Resolve<IMessengerService>();
                messengerService.Register<TaskProgressMessage>(this, HandleTaskProgressMessage);

                var context = new FileConversionContext
                {
                    SourceFile = SourceFileName,
                    TargetFolder = TargetFolderName,
                };

                try
                {
                    _cancellationTokenSource = new CancellationTokenSource();
                    var result = await Task.Run(() => consoleService.ProcessFilesAsync(context, _cancellationTokenSource.Token));
                }
                catch (TaskCanceledException taskCanceledException)
                {
                    _logger.LogError("Operation Cancelled", taskCanceledException);
                }
                finally
                {
                    _cancellationTokenSource.Dispose();
                }

                CanStartProcessing = true;
                CanSelectFileFolder = true;
            }
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
