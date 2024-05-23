using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Models
{
    public class ProductType
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public ProductType(int id, string type)
        {
            Id = id;
            Type = type;
        }
    }
}
