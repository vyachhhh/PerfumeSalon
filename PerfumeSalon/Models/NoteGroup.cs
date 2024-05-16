using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    public class NoteGroup
    {
        public int Id { get; set; }
        public string GroupName { get; set; }
        public BitmapImage Image { get; set; }
        public int Quantity { get; set; }
        public NoteGroup(int id, string notesGroup, Uri path, int quantity)
        {
            Id = id;
            GroupName = notesGroup;
            Image = new BitmapImage(path);
            Quantity = quantity;
        }
    }
}
