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
    /// Логика взаимодействия для AdminBasketPage.xaml
    /// </summary>
    public partial class AdminOrderPage : Page
    {
        List<Order> orders = new List<Order>();
        public AdminOrderPage()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadData();
            dpDateAft.SelectedDate = new DateTime(2023,1,1);
            dpDateBef.SelectedDate = new DateTime(2025,1,1);
            tbSearch.Text = "";
        }

        private void LoadData()
        {
            orders = dbOrder.ShowOrderAll();
            dgOrder.ItemsSource = orders;
        }

        private void DataGridCell_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            int index = dgOrder.SelectedIndex;
            int orderId = orders[index].Id;
            FrameClass.BodyFrame.Navigate(new Pages.OrderInfoPage(orderId));
        }

        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            SearchOrder();
        }

        private void dpDateAft_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            SearchOrder();
        }

        private void dpDateBef_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            SearchOrder();
        }

        private void SearchOrder()
        {
            if (dpDateAft != null && dpDateBef != null && dgOrder != null)
            {
                orders = dbOrder.SearchOrder(tbSearch.Text, dpDateAft.SelectedDate.Value, dpDateBef.SelectedDate.Value);
                dgOrder.ItemsSource = orders;
            }
        }
    }
}
