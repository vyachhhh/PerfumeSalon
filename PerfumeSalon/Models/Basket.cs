using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class Basket
    {
        public int CustomerId { get; set; }
        public int ProductId { get; set; }
        public int Quanity { get; set; }
        public Basket() { }
        public Basket(int customerId, int productId, int quantity)
        {
            CustomerId = customerId;
            ProductId = productId;
            Quanity = quantity;
        }
    }
}
