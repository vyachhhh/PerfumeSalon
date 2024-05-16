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
    public class AromaGroup
    {
        public int Id { get; set; }
        public string GroupName { get; set; }
        public BitmapImage Image { get; set; }
        public int Quantity { get; set; }
        public AromaGroup(int id, string name, Uri path, int quantity)
        {
            Id = id;
            GroupName = name;
            //Uri uri = new Uri(path, UriKind.Relative);
            //Image = new BitmapImage(uri);
            //Uri uri = new Uri("/Resources/AromasGroups/Восточные.jpg", UriKind.Relative);
            Image = new BitmapImage(path);
            Quantity = quantity;
        }
    }
}
