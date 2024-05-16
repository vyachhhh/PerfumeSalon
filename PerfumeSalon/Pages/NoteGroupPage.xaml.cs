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
    /// Логика взаимодействия для NotesGroupPage.xaml
    /// </summary>
    public partial class NoteGroupPage : Page
    {
        List<NoteGroup> notesGroups = new List<NoteGroup>();
        public NoteGroupPage()
        {
            InitializeComponent();
            notesGroups = dbNoteGroup.LoadFromDB();
            ListViewGroups.Items.Clear();
            ListViewGroups.ItemsSource = notesGroups;
        }

        private void ListViewGroups_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int index = ListViewGroups.SelectedIndex;
            //string group = aromasGroups[index].AromasGroup;
            //MessageBox.Show(group);
            int id = notesGroups[index].Id;
            FrameClass.BodyFrame.Navigate(new Pages.NotePickPage(id));
        }
    }
}
