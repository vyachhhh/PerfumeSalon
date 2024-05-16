using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    public class Product
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Category { get; set; }
        public string Aroma { get; set; }
        public int Volume { get; set; }
        public int Price { get; set; }
        public int Quantity { get; set; }
        public BitmapImage Image { get; set; }
        public Product() { }
        public Product(int id, string type, string category, string aroma, int volume, int price)
        {
            Id = id;
            Type = type;
            Category = category;
            Aroma = aroma;
            Volume = volume;
            Price = price;
            Uri uri = new Uri($"/Resources/Volumes/{volume}.jpg", UriKind.Relative);
            Image = new BitmapImage(uri);
        }
        public Product(int id, string type, string category, string aroma, int volume, int price, int quantity)
        {
            Id = id;
            Type = type;
            Category = category;
            Aroma = aroma;
            Volume = volume;
            Price = price;
            Quantity = quantity;
            Uri uri = new Uri($"/Resources/Volumes/{volume}.jpg", UriKind.Relative);
            Image = new BitmapImage(uri);
        }
    }
}
