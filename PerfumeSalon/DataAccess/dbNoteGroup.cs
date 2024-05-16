using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using PerfumeSalon.Models;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    public class dbNoteGroup
    {
        public static List<NoteGroup> LoadFromDB()
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select NG.[id],NG.[NoteGroup],[Image], count(N.[id])" +
                " from NoteGroup NG left join Note N on N.NoteGroup = NG.id" +
                " group by NG.[id], NG.[NoteGroup],[Image]" +
                " order by count(N.[id]) desc", connect);
            List<NoteGroup> spisok = new List<NoteGroup>();
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new NoteGroup(reader.GetInt32(0), reader.GetString(1),
                        new Uri(@"C:\Users\I'm\Desktop\PerfumeSalon\PerfumeSalon" + reader.GetString(2), UriKind.Relative), reader.GetInt32(3)));
                    //spisok.Add(new NoteGroup(reader.GetInt32(0), reader.GetString(1),
                    //    new Uri(@"C:\Users\stud\Desktop\PerfumeSalon\PerfumeSalon" + reader.GetString(2), UriKind.Relative), reader.GetInt32(3)));
                    //spisok.Add(new NoteGroup(reader.GetInt32(0), reader.GetString(1),
                    //    new Uri(reader.GetString(2), UriKind.Relative), reader.GetInt32(3)));

                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
    }
}
