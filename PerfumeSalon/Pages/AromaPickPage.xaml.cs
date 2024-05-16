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
    /// Логика взаимодействия для AromaPick.xaml
    /// </summary>
    public partial class AromaPickPage : Page
    {
        public int id;
        public static List<Aroma> aromas = new List<Aroma>();
        public AromaPickPage(int id = 0)
        {
            InitializeComponent();
            this.id = id;
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            aromas = dbAroma.LoadFromDB(id);
            ListViewAromas.ItemsSource = null;
            ListViewAromas.Items.Clear();
            ListViewAromas.ItemsSource = aromas;
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
