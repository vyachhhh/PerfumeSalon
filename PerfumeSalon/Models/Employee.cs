using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class Employee : Customer
    {
        public string Address { get; set; }
        public Employee(int id, string fname, string mname, string lname, string email, string phone, string address, string login)
        {
            Id = id;
            FirstName = fname;
            MiddleName = mname;
            LastName = lname;
            Email = email;
            Phone = phone;
            Address = address;
            Login = login;
        }
        public Employee() { }
    }
}
