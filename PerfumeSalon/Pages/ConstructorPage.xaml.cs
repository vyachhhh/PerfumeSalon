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
    /// Логика взаимодействия для ConstructorPage.xaml
    /// </summary>
    public partial class ConstructorPage : Page
    {
        List<Note> note = new List<Note>();
        List<NoteGroup> noteGroup = new List<NoteGroup>();
        List<AromaGroup> aromaGroup = new List<AromaGroup>();
        public ConstructorPage()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            cbNoteGroup.SelectedIndex = 0;
            LoadComboBox();
        }
        private void LoadComboBox()
        {
            noteGroup = dbNoteGroup.LoadFromDB();
            cbNoteGroup.ItemsSource = noteGroup;
            aromaGroup = dbAromaGroup.LoadFromDB();
            cbAromaGroup.ItemsSource = aromaGroup;
        }

        private void cbNoteGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            SearchNote();
        }

        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            SearchNote();
        }
        private void SearchNote()
        {
            note = dbNote.SearchNote(Convert.ToInt32(cbNoteGroup.SelectedValue), tbSearch.Text);
            cbNote.ItemsSource = note;
        }

        private void btnAddAromaGroup_Click(object sender, RoutedEventArgs e)
        {
            if (cbAromaGroup.SelectedItem != null) cbAromaGroupSelected.Items.Add(cbAromaGroup.SelectedItem);
        }

        private void btnAddNoteTop_Click(object sender, RoutedEventArgs e)
        {
            if (cbNote.SelectedItem != null) cbNoteClassTop.Items.Add(cbNote.SelectedItem);
        }

        private void btnAddNoteMid_Click(object sender, RoutedEventArgs e)
        {
            if (cbNote.SelectedItem != null) cbNoteClassMid.Items.Add(cbNote.SelectedItem);
        }

        private void btnAddNoteBot_Click(object sender, RoutedEventArgs e)
        {
            if (cbNote.SelectedItem != null) cbNoteClassBot.Items.Add(cbNote.SelectedItem);
        }

        private void cbAromaGroupSelected_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbAromaGroupSelected.SelectedItem != null)
            {
                cbAromaGroupSelected.Items.Remove(cbAromaGroupSelected.SelectedItem);
                cbAromaGroupSelected.Text = "группы";
            }
        }

        private void cbNoteClassTop_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbNoteClassTop.SelectedItem != null)
            {
                cbNoteClassTop.Items.Remove(cbNoteClassTop.SelectedItem);
                cbNoteClassTop.Text = "верхние ноты";
            }
        }

        private void cbNoteClassMid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbNoteClassMid.SelectedItem != null)
            {
                cbNoteClassMid.Items.Remove(cbNoteClassMid.SelectedItem);
                cbNoteClassMid.Text = "средние ноты";
            }
        }

        private void cbNoteClassBot_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbNoteClassBot.SelectedItem != null)
            {
                cbNoteClassBot.Items.Remove(cbNoteClassBot.SelectedItem);
                cbNoteClassBot.Text = "нижние ноты";
            }
        }

        private void btnAddAroma_Click(object sender, RoutedEventArgs e)
        {
            List<AromaGroup> group = cbAromaGroupSelected.Items.OfType<AromaGroup>().ToList();
            List<Note> topNoteList = cbNoteClassTop.Items.OfType<Note>().ToList();
            List<Note> midNoteList = cbNoteClassMid.Items.OfType<Note>().ToList();
            List<Note> botNoteList = cbNoteClassBot.Items.OfType<Note>().ToList();
            if (group.Count > 0 && topNoteList.Count > 0 && midNoteList.Count > 0 && botNoteList.Count > 0)
            {
                List<List<Note>> noteList = new List<List<Note>> { topNoteList, midNoteList, botNoteList };
                dbAroma.AddAroma(tbAromaName.Text, tbDescription.Text, group, noteList);
            }
            else
            {
                MessageBox.Show("Заполнены не все списки!");
            }
        }

        private void btnClear_Click(object sender, RoutedEventArgs e)
        {
            tbAromaName.Text = "";
            tbDescription.Text = "";
            cbAromaGroupSelected.Items.Clear();
            cbNoteClassTop.Items.Clear();
            cbNoteClassMid.Items.Clear();
            cbNoteClassBot.Items.Clear();
        }
    }
}
