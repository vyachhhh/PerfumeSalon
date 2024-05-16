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
    /// Логика взаимодействия для OrderInfoPage.xaml
    /// </summary>
    public partial class OrderInfoPage : Page
    {
        public List<Product> products = new List<Product>();
        public int orderId = 0;
        public OrderInfoPage(int orderId)
        {
            InitializeComponent();
            this.orderId = orderId;
        }

        private void ListViewAromas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ListViewAromas.Items.Count > 0)
            {
                int index = ListViewAromas.SelectedIndex;
                int id = products[index].Id;
                int aromaId = dbBasket.GetAromaIdFromProduct(id);
                FrameClass.BodyFrame.Navigate(new Pages.AromaInfo(aromaId));
            }
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            products = dbOrder.ShowOrderInfo(orderId);
            ListViewAromas.ItemsSource = null;
            ListViewAromas.Items.Clear();
            ListViewAromas.ItemsSource = products;
        }
    }
}
