using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    public class Aroma
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }
        public int Price { get; set; }
        public BitmapImage Image { get; set; }
        public Aroma(int id, string name, string description, string type, int price, int volume)
        {
            Id = id;
            Name = name;
            Description = description;
            Type = type;
            Price = price;
            //Uri uri = new Uri(@"C:\Users\I'm\Desktop\PerfumeSalon\PerfumeSalon\Resources\Volumes\" + volume.ToString() + ".jpg", UriKind.Relative);
            Uri uri = new Uri($"/Resources/Volumes/{volume}.jpg", UriKind.Relative);
            Image = new BitmapImage(uri);
        }
        public Aroma() { }
        public Aroma(int id, string name, string description)
        {
            Id = id;
            Name = name;
            Description = description;
        }
    }
}
