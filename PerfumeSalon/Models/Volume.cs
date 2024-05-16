using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class Volume
    {
        public int Id { get; set; }
        public int Value { get; set; }
        public Volume (int id, int value)
        {
            Id = id;
            Value = value;
        }
    }
}
