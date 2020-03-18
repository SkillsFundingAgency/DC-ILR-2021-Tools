using System.Windows;

namespace ESFA.Common.Service
{
    public partial class MessageView : Window
    {

        public MessageView()
        {
            InitializeComponent();
        }

        protected MessageBoxResult Result { get; private set; }

        protected MessageBoxButton MessageButton
        {
            set
            {
                switch (value)
                {
                    case MessageBoxButton.OK:
                        OKButton.Visibility = Visibility.Visible;
                        break;
                    case MessageBoxButton.OKCancel:
                        OKButton.Visibility = Visibility.Visible;
                        CancelButton.Visibility = Visibility.Visible;
                        break;
                    case MessageBoxButton.YesNo:
                        YesButton.Visibility = Visibility.Visible;
                        NoButton.Visibility = Visibility.Visible;
                        break;
                    case MessageBoxButton.YesNoCancel:
                        YesButton.Visibility = Visibility.Visible;
                        NoButton.Visibility = Visibility.Visible;
                        CancelButton.Visibility = Visibility.Visible;
                        break;
                    default:
                        OKButton.Visibility = Visibility.Visible;
                        break;
                }
            }
        }

        public string MessageText
        {
            get { return _messageText.Text; }
            set { _messageText.Text = value; }
        }

        public static MessageBoxResult Show(string caption)
        {
            return Show(caption, string.Empty, MessageBoxButton.OK);
        }

        public static MessageBoxResult Show(string caption, string title)
        {
            return Show(caption, title, MessageBoxButton.OK);
        }

        public static MessageBoxResult Show(string caption, string title, MessageBoxButton button)
        {
            var win = new MessageView()
            {
                MessageText = caption,
                Title = title,
                MessageButton = button,
            };

            win.ShowDialog();
            var result = win.Result;

            win.Close();
            win = null;

            return result;
        }

        private void OKButton_Click(object sender, RoutedEventArgs e)
        {
            Result = MessageBoxResult.OK;
            Hide();
        }

        private void YesButton_Click(object sender, RoutedEventArgs e)
        {
            Result = MessageBoxResult.Yes;
            Hide();
        }

        private void NoButton_Click(object sender, RoutedEventArgs e)
        {
            Result = MessageBoxResult.No;
            Hide();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Result = MessageBoxResult.Cancel;
            Hide();
        }
    }
}
