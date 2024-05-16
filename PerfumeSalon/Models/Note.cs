using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    public class Note
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int GroupName { get; set; }
        public BitmapImage Image { get; set; }
        public Note(int id, string note, int noteGroup)
        {
            Id = id;
            Name = note;
            GroupName = noteGroup;
        }
    }
}
