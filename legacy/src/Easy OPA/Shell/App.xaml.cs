using EasyOPA.View;
using System.Windows;
using Tiny.Framework.Bootstrap;

namespace EasyOPA
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="App"/> class.
        /// </summary>
        public App()
        {
            Bootstrap.Start<MainPage>(SetMainPage);
        }

        /// <summary>
        /// Sets the main page.
        /// </summary>
        /// <param name="withThisPage">with this page.</param>
        public void SetMainPage(MainPage withThisPage)
        {
            var win = new Window
            {
                MinWidth = withThisPage.MinWidth + 50,
                MinHeight = withThisPage.MinHeight + 50,
                Width = withThisPage.MinWidth + 50,
                Height = withThisPage.MinHeight + 50,
                Title = withThisPage.Title,
                Content = withThisPage,
                SizeToContent = SizeToContent.Manual,
                WindowStartupLocation = WindowStartupLocation.CenterScreen
            };

            Current.MainWindow = win;

            win.Show();
        }
    }
}
