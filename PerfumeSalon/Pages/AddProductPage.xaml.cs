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
using PerfumeSalon.Models;

namespace PerfumeSalon.Pages
{
    /// <summary>
    /// Логика взаимодействия для AddProductPage.xaml
    /// </summary>
    public partial class AddProductPage : Page
    {

        List<Aroma> aromas = new List<Aroma>();
        List<ProductType> types = new List<ProductType>();
        List<ProductCategory> categories = new List<ProductCategory>();
        List<Volume> volumes = new List<Volume>();

        public AddProductPage()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadComboBoxes();
        }

        private void LoadComboBoxes()
        {
            aromas = dbAroma.LoadAromaToComboBox();
            types = dbProduct.LoadProductTypeToComboBox();
            categories = dbProduct.LoadProductCategoryToComboBox();
            volumes = dbProduct.LoadVolumeToComboBox();

            cbAroma.ItemsSource = aromas;
            cbProductType.ItemsSource = types;
            cbProductCategory.ItemsSource = categories;
            cbVolume.ItemsSource = volumes;
        }

        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int price = Convert.ToInt32(tbPrice.Text);
                if (price > 0)
                {
                    dbProduct.AddProductToAroma(Convert.ToInt32(cbProductType.SelectedValue),
    Convert.ToInt32(cbProductCategory.SelectedValue),
    Convert.ToInt32(cbAroma.SelectedValue),
    Convert.ToInt32(cbVolume.SelectedValue),
    price);
                }
                else
                {
                    throw new FormatException();
                }
            }
            catch
            {
                MessageBox.Show("Не верно указана стоимость");
            }
        }

        private void btnClear_Click(object sender, RoutedEventArgs e)
        {
            tbPrice.Text = "0";
            cbProductType.SelectedItem = null;
            cbProductCategory.SelectedItem = null;
            cbAroma.SelectedItem = null;
            cbVolume.SelectedItem = null;
        }
    }
}
