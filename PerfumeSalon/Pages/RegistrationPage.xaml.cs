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
    /// Логика взаимодействия для RegistrationPAge.xaml
    /// </summary>
    public partial class RegistrationPage : Page
    {
        public RegistrationPage()
        {
            InitializeComponent();
        }

        public void btnRegistration_Click(object sender, RoutedEventArgs e)
        {
            if (tbxPassword.Password == tbxPasswordConfirm.Password)
            {
                if (tbxLogin.Text == "" || 
                    tbxPassword.Password.Length == 0 || 
                    tbxPasswordConfirm.Password.Length == 0 ||
                    tbxFName.Text == "" ||
                    tbxMName.Text == "" ||
                    tbxLName.Text == "" ||
                    tbxEmail.Text == "" ||
                    tbxPhone.Text == "")
                {
                    MessageBox.Show("Заполните все поля");
                }
                else
                {
                    dbUser.RegisterNewUser(tbxLogin.Text, tbxPassword.Password, tbxFName.Text, tbxMName.Text,
                tbxLName.Text, tbxEmail.Text, tbxPhone.Text);
                    User user = dbUser.Login(tbxLogin.Text, tbxPassword.Password);
                    if (user.Id != 0)
                    {
                        MessageBox.Show("Авторизация прошла успешно");
                        FrameClass.BodyFrame.Navigate(new Pages.UserProfilePage());
                    }
                }
            }
            else
            {
                MessageBox.Show("Ошибка подтверждения пароля");
            }
        }

        private void Page_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                btnRegistration_Click(sender, e);
            }
        }
    }
}
