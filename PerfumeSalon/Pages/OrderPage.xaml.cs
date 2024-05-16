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
    /// Логика взаимодействия для OrderPage.xaml
    /// </summary>
    public partial class OrderPage : Page
    {
        public List<Product> products = new List<Product>();
        public OrderPage(List<Product> products)
        {
            InitializeComponent();
            this.products = products;
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            FrameClass.BodyFrame.Navigate(new Pages.BasketPage());
        }

        private void btnOrder_Click(object sender, RoutedEventArgs e)
        {
            dbOrder.CreateOrder(UserId.userId, DateTime.Now, tbxAddress.Text);
            int orderId = dbOrder.GetLastOrderId(UserId.userId, tbxAddress.Text);
            foreach (Product p in products)
            {
                dbOrder.CreateOrderInfo(orderId, p.Id, p.Quantity);
            }
            MessageBox.Show("Заказ создан!");
            FrameClass.BodyFrame.Navigate(new Pages.BasketPage());
        }
    }
}
