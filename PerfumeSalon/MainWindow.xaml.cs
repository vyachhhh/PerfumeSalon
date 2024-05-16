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

namespace PerfumeSalon
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            FrameClass.BodyFrame = FrameBody;
            //Button btn = new Button();
            //btn.Style = btnOpenAromas.Style;

            //btnOpenNotes.Style = btn.Style;
            //btnOpenConstructor.Style = btn.Style;
            //btnOpenPerfumes.Style = btn.Style;
            FrameClass.BodyFrame.Navigate(new Pages.PerfumePickPage());
            btnOpenConstructor.Visibility = Visibility.Hidden;
        }

        private void btnOpenAromas_Click(object sender, RoutedEventArgs e)
        {
            //FrameClass.BodyFrame.Navigate(new Pages.AromaPickPage());
            //FrameClass.BodyFrame.Navigate(new Pages.AromaInfo());
            FrameClass.BodyFrame.Navigate(new Pages.AromaGroupPage());
        }

        private void btnOpenNotes_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.NoteGroupPage());
        }

        private void btnOpenPerfumes_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.PerfumePickPage());
        }

        private void btnOpenConstructor_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.ConstructorPage());
        }

        private void btnOpenProfile_Click(object sender, RoutedEventArgs e)
        {
            if (UserId.userId == 0)
            {
                FrameClass.BodyFrame.Navigate(new Pages.LoginPage());
            }
            else
            {
                FrameClass.BodyFrame.Navigate(new Pages.UserProfilePage());
            }
        }

        private void btnOpenFavorites_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.FavoriteAromaPage());
        }

        private void btnOpenBasket_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.BasketPage());
        }
    }
}
