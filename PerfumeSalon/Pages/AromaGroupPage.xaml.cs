using PerfumeSalon.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
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

namespace PerfumeSalon.Pages
{
    /// <summary>
    /// Логика взаимодействия для AromasGroupPage.xaml
    /// </summary>
    public partial class AromaGroupPage : Page
    {
        List<AromaGroup> aromaGroups = new List<AromaGroup>();
        public AromaGroupPage()
        {
            InitializeComponent();
            aromaGroups = dbAromaGroup.LoadFromDB();
            ListViewGroups.Items.Clear();
            ListViewGroups.ItemsSource = aromaGroups;
        }

        private void ListViewGroups_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int index = ListViewGroups.SelectedIndex;
            int id = aromaGroups[index].Id;
            FrameClass.BodyFrame.Navigate(new Pages.AromaPickPage(id));
        }
    }
}
