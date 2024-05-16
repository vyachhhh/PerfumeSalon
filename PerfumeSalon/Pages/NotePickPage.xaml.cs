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
    /// Логика взаимодействия для NotePick.xaml
    /// </summary>
    public partial class NotePickPage : Page
    {
        public int id;
        public List<Note> notes = new List<Note>();
        public NotePickPage(int id)
        {
            InitializeComponent();
            this.id = id;
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            notes = dbNote.LoadFromDB(id);
            ListViewNotes.Items.Clear();
            ListViewNotes.ItemsSource = notes;
        }

        private void ListViewNotes_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
