using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PerfumeSalon.Classes
{
    public class NoteInAroma
    {
        public int NoteClass { get; set; }
        public string Note { get; set; }
        public NoteInAroma(int noteClass ,string note)
        {
            NoteClass = noteClass;
            Note = note;
        }
    }
}
