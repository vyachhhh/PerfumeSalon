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
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            tbxLogin.IsEnabled = false;
            profile = dbUser.GetProfileByUserId(UserId.userId);
            tbxLogin.Text = profile.Login;
            tbxPassword.Text = "●●●●●●●●";
            tbxFName.Text = profile.FirstName;
            tbxMName.Text = profile.MiddleName;
            tbxLName.Text = profile.LastName;
            tbxEmail.Text = profile.Email;
            tbxPhone.Text = profile.Phone;
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            if (tbxPassword.Text == "●●●●●●●●")
            {
                dbUser.EditProfileWithoutPassword(profile.Id, tbxFName.Text, tbxMName.Text,
                    tbxLName.Text, tbxEmail.Text, tbxPhone.Text);
            }
            else
            {
                dbUser.EditProfile(profile.Id, profile.Login, tbxPassword.Text,
                    tbxFName.Text, tbxMName.Text,
                    tbxLName.Text, tbxEmail.Text, tbxPhone.Text);
            }
        }
    }
}
