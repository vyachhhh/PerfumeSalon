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
    /// Логика взаимодействия для UsersOrderPage.xaml
    /// </summary>
    public partial class UserOrderPage : Page
    {
        List<Order> orders = new List<Order>();
        public UserOrderPage()
        {
            InitializeComponent();
        }

        private void ListViewOrders_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ListViewOrders.Items.Count > 0)
            {
                int index = ListViewOrders.SelectedIndex;
                int orderId = orders[index].Id;
                FrameClass.BodyFrame.Navigate(new Pages.OrderInfoPage(orderId));
            }
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            orders = dbOrder.ShowOrder(UserId.userId);
            ListViewOrders.ItemsSource = null;
            ListViewOrders.Items.Clear();
            ListViewOrders.ItemsSource = orders;
        }
    }
}
