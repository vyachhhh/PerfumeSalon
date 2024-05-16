using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class Customer
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Login { get; set; }
        public Customer(int id, string fname, string mname, string lname, string email, string phone, string login)
        {
            Id = id;
            FirstName = fname;
            MiddleName = mname;
            LastName = lname;
            Email = email;
            Phone = phone;
            Login = login;
        }
        public Customer() { }
    }
}
