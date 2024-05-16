using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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
    /// Логика взаимодействия для BasketPage.xaml
    /// </summary>
    public partial class BasketPage : Page
    {
        public static List<Product> products = new List<Product>();
        public static ListView lvPlaceholder = new ListView();
        public BasketPage()
        {
            InitializeComponent();
            DataContext = new CmdDelete(); 
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadProducts();
            if (products.Count > 0)
            {
                gridEmpty.Visibility = Visibility.Collapsed;
            }
            else
            {
                gridEmpty.Visibility = Visibility.Visible;
                gridList.Visibility = Visibility.Collapsed;
            }
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

        public void LoadProducts()
        {
            products = dbBasket.GetProductFromBasket(UserId.userId);
            //UpdateProducts();
            ListViewAromas.ItemsSource = null;
            ListViewAromas.Items.Clear();
            ListViewAromas.ItemsSource = products;
            //ListViewProducts.lvPlaceholder = ListViewAromas;
        }
        public static void UpdateProducts()
        {
            ListViewProduct.lvPlaceholder.ItemsSource = null;
            ListViewProduct.lvPlaceholder.Items.Clear();
            ListViewProduct.lvPlaceholder.ItemsSource = products;
        }

        private void btnDeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            LoadProducts();
        }

        private void btnOrder_Click(object sender, RoutedEventArgs e)
        {
            if (ListViewAromas.Items.Count > 0)
            {
                FrameClass.BodyFrame.Navigate(new Pages.OrderPage(products));
            }
            else
            {
                MessageBox.Show("Корзина пуста");
            }
        }

        private void btnShowOrders_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.UserOrderPage());
        }
    }
}
