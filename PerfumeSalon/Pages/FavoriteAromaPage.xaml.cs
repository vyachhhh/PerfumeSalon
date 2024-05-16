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
    /// Логика взаимодействия для FavoriteProductsPage.xaml
    /// </summary>
    public partial class FavoriteAromaPage : Page
    {
        public static List<Aroma> aromas = new List<Aroma>();
        public FavoriteAromaPage()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            aromas = dbAroma.GetFavoriteAroma(UserId.userId);
            ListViewAromas.ItemsSource = null;
            ListViewAromas.Items.Clear();
            if (aromas.Count > 0)
            {
                ListViewAromas.ItemsSource = aromas;
                gridEmpty.Visibility = Visibility.Collapsed;
                gridList.Margin = new Thickness(0,0,0,0);
            }
            else
            {
                gridEmpty.Visibility = Visibility.Visible;
                gridList.Margin = new Thickness(0, 40, 0, 0);
                ListViewAromas.Visibility = Visibility.Collapsed;
            }
        }

        private void ListViewAromas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ListViewAromas.Items.Count > 0)
            {
                int index = ListViewAromas.SelectedIndex;
                int id = aromas[index].Id;
                FrameClass.BodyFrame.Navigate(new Pages.AromaInfo(id));
            }
        }
    }
}
