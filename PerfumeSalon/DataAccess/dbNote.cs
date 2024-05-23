using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using PerfumeSalon.Models;

namespace PerfumeSalon.Classes
{
    class dbNote
    {
        public static List<Note> LoadFromDB(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select N.[id],N.[Note], NG.id" +
                " from Note N join[dbo].[NoteGroup] NG on NG.id = N.NoteGroup" +
                " where NG.id = @id", connect);
            List<Note> spisok = new List<Note>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Note(reader.GetInt32(0), reader.GetString(1), reader.GetInt32(2)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static List<Note> SearchNote(int groupId, string search)
        {
            if (search.Equals("")) search = "%";
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from SearchNote(@groupId, @search)", connect);
            List<Note> list = new List<Note>();
            command.Parameters.AddWithValue("@groupId", groupId);
            command.Parameters.AddWithValue("@search", search);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    list.Add(new Note(reader.GetInt32(0), reader.GetString(1), reader.GetInt32(2)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return list;
        }
    }
}
