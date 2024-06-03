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
    /// Логика взаимодействия для PerfumePickPage.xaml
    /// </summary>
    public partial class PerfumePickPage : Page
    {
        public static List<Aroma> aromas = new List<Aroma>();
        public static List<AromaGroup> aromasGroup = new List<AromaGroup>();
        public static List<string> productsTypes = new List<string>();
        public static List<Note> notes = new List<Note>();
        public PerfumePickPage()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            cbSortList.Items.Clear();
            cbAromasGroups.Items.Clear();
            cbProductType.Items.Clear();

            aromasGroup = dbAromaGroup.LoadFromDB();
            foreach (AromaGroup ag in aromasGroup)
            {
                cbAromasGroups.Items.Add(ag.GroupName);
            }
            productsTypes = dbProduct.GetProductTypes();
            foreach (string pt in productsTypes)
            {
                cbProductType.Items.Add(pt);
            }
            cbAromasGroups.Items.Add("");
            cbProductType.Items.Add("");
            cbAromasGroups.Text = "";
            cbProductType.Text = "";

            cbSortList.Items.Add("по названию");
            cbSortList.Items.Add("по возрастанию цены");
            cbSortList.Items.Add("по убыванию цены");

            cbSortList.SelectedIndex = 0;
            cbAromasGroups.SelectedIndex = cbAromasGroups.Items.Count-1;
            cbProductType.SelectedIndex = cbProductType.Items.Count - 1;

            notes = dbNote.GetUsedNote();
            cbNote.Items.Add("все");
            cbNote.SelectedValue = 0;
            foreach (Note n in notes)
            {
                cbNote.Items.Add(n);
            }

            UpdateList(0,"%","%","%", Convert.ToInt32(cbNote.SelectedValue) -1);
        }
        public void UpdateList(int index, string aromasGroup, string type, string search, int noteId)
        {
            aromas = dbAroma.SearchAroma(index, aromasGroup, type, search, noteId);
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

        private async void tbxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            await Task.Delay(1);
            UpdateList(cbSortList.SelectedIndex, cbAromasGroups.Text,
            cbProductType.Text, tbxSearch.Text, Convert.ToInt32(cbNote.SelectedValue));
        }

        private async void cbSortList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbSortList.Items.Count > 0)
            {
                int selectedComboBoxIndex = cbSortList.SelectedIndex;
                await Task.Delay(1);
                UpdateList(selectedComboBoxIndex, cbAromasGroups.Text,
                cbProductType.Text, tbxSearch.Text, Convert.ToInt32(cbNote.SelectedValue));
            }
        }

        private async void cbAromasGroups_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbAromasGroups.Items.Count > 0)
            {
                string selectedComboBoxItem = cbAromasGroups.SelectedItem.ToString();
                await Task.Delay(1);
                UpdateList(cbSortList.SelectedIndex, selectedComboBoxItem.ToString(),
                cbProductType.Text, tbxSearch.Text, Convert.ToInt32(cbNote.SelectedValue));
            }
        }

        private async void cbProductType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbProductType.Items.Count > 0)
            {
                string selectedComboBoxItem = cbProductType.SelectedItem.ToString();
                await Task.Delay(1);
                UpdateList(cbSortList.SelectedIndex, cbAromasGroups.Text,
                selectedComboBoxItem.ToString(), tbxSearch.Text, Convert.ToInt32(cbNote.SelectedValue));
            }
        }

        private async void cbNote_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbNote.Items.Count > 0)
            {
                int selectedComboBoxItem = Convert.ToInt32(cbNote.SelectedValue);
                await Task.Delay(1);
                UpdateList(cbSortList.SelectedIndex, cbAromasGroups.Text,
                cbProductType.Text, tbxSearch.Text, Convert.ToInt32(cbNote.SelectedValue));
            }
        }
    }
}
