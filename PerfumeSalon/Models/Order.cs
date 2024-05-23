using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class Order
    {
        public int Id { get; set; }
        public string Customer { get; set; }
        public DateTime Date { get; set; }
        public string Address { get; set; }
        public int TotalPrice { get; set; }
        public Order() { }
        public Order(int id, DateTime date, string address, int totalprice)
        {
            Id = id;
            Date = date;
            Address = address;
            TotalPrice = totalprice;
        }
        public Order(int id, string customer, DateTime date, string address, int totalPrice)
        {
            Id = id;
            Customer = customer;
            Date = date;
            Address = address;
            TotalPrice = totalPrice;
        }
    }
}
