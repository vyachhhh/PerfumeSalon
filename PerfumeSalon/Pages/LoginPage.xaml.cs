using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using PerfumeSalon.Classes;

namespace PerfumeSalon.Pages
{
    /// <summary>
    /// Логика взаимодействия для LoginPage.xaml
    /// </summary>
    public partial class LoginPage : Page
    {
        User user = new User();
        public LoginPage()
        {
            InitializeComponent();
        }

        private void btnRegistration_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.RegistrationPage());
        }

        private void Page_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                btnLogin_Click(sender, e);
            }
        }

        public void btnLogin_Click(object sender, RoutedEventArgs e)
        {
            user = dbUser.Login(tbxLogin.Text, tbxPassword.Password);
            if (UserId.userId != 0)
            {
                FrameClass.BodyFrame.Navigate(new Pages.UserProfilePage());
            }
        }
    }
}
