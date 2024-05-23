using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class User
    {
        public int Id { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public int Role { get; set; }
        public User(int id, string login, string password, int role)
        {
            Id = id;
            Login = login;
            Password = password;
            Role = role;

            UserId.userId = Id;
            UserId.roleId = role;
        }
        public User() { }
    }
}
