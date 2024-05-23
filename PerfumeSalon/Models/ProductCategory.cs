using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Models
{
    public class ProductCategory
    {
        public int Id { get; set; }
        public string Category { get; set; }
        public ProductCategory(int id, string category)
        {
            Id = id;
            Category = category;
        }
    }
}
