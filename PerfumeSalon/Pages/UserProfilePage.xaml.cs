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
    /// Логика взаимодействия для UserProfilePage.xaml
    /// </summary>
    public partial class UserProfilePage : Page
    {
        public static Profile profile = new Profile();
        public UserProfilePage()
        {
            InitializeComponent();
            if (UserId.roleId == 2)
            {
                btnConstructor.Visibility = Visibility.Collapsed;
                btnAddProduct.Visibility = Visibility.Collapsed;
                btnOrder.Visibility = Visibility.Collapsed;
            }
            else
            {
                tbxLogin.Visibility = Visibility.Collapsed;
                tbxPassword.Visibility = Visibility.Collapsed;
                tbxFName.Visibility = Visibility.Collapsed;
                tbxMName.Visibility = Visibility.Collapsed;
                tbxLName.Visibility = Visibility.Collapsed;
                tbxEmail.Visibility = Visibility.Collapsed;
                tbxPhone.Visibility = Visibility.Collapsed;
                btnSave.Visibility = Visibility.Collapsed;
            }
        }
        int passwordHash = 0;

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            tbxLogin.IsEnabled = false;
            profile = dbUser.GetProfileByUserId(UserId.userId);
            if (profile.Id != 0)
            {
                tbxLogin.Text = profile.Login;
                tbxPassword.Password = profile.Password;
                passwordHash = tbxPassword.Password.GetHashCode();
                tbxFName.Text = profile.FirstName;
                tbxMName.Text = profile.MiddleName;
                tbxLName.Text = profile.LastName;
                tbxEmail.Text = profile.Email;
                tbxPhone.Text = profile.Phone;
            }
            else
            {
                tbxLogin.Visibility = Visibility.Collapsed;
                tbxPassword.Visibility = Visibility.Collapsed;
                tbxFName.Visibility = Visibility.Collapsed;
                tbxMName.Visibility = Visibility.Collapsed;
                tbxLName.Visibility = Visibility.Collapsed;
                tbxEmail.Visibility = Visibility.Collapsed;
                tbxPhone.Visibility = Visibility.Collapsed;
                btnSave.Visibility = Visibility.Collapsed;
            }

        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            if (passwordHash == tbxPassword.Password.GetHashCode())
            {
                dbUser.EditProfileWithoutPassword(profile.Id, tbxFName.Text, tbxMName.Text,
                    tbxLName.Text, tbxEmail.Text, tbxPhone.Text);
            }
            else
            {
                dbUser.EditProfile(profile.Id, profile.Login, tbxPassword.Password,
                    tbxFName.Text, tbxMName.Text,
                    tbxLName.Text, tbxEmail.Text, tbxPhone.Text);
            }
        }

        private void btnConstructor_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.ConstructorPage());
        }

        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.AddProductPage());
        }

        private void btnOrder_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.AdminOrderPage());
        }

        private void btnLogOut_Click(object sender, RoutedEventArgs e)
        {
            UserId.userId = 0;
            UserId.roleId = 2;
            FrameClass.BodyFrame.Navigate(new Pages.LoginPage());
        }
    }
}
