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
    class dbAroma
    {
        public static List<Aroma> LoadFromDB(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select A.[id],A.[Aroma],[Description],PT.Type,MIN([Price]), Min(V.Volume)" +
                " from Aroma A join Product P on P.Aroma = A.id" +
                " join ProductType PT on PT.id = P.ProductType" +
                " join AromaGroupInAroma AGA on AGA.Aroma = A.id" +
                " join Volume V on V.id = P.Volume" +
                " where AGA.AromaGroup = @id" +
                " group by A.[id], A.[Aroma],[Description], PT.Type", connect);
            List<Aroma> spisok = new List<Aroma>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Aroma(reader.GetInt32(0), reader.GetString(1),
                        reader.GetString(2), reader.GetString(3), reader.GetInt32(4), reader.GetInt32(5)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static Aroma LoadAromaById(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select A.[id],A.[Aroma],[Description],PT.Type,MIN([Price]), Min(V.Volume) " +
                " from Aroma A join Product P on P.Aroma = A.id" +
                " join ProductType PT on PT.id = P.ProductType" +
                " join AromaGroupInAroma AGA on AGA.Aroma = A.id" +
                " join Volume V on V.id = P.Volume" +
                " where AGA.AromaGroup = @id" +
                " group by A.[id], A.[Aroma],[Description], PT.Type", connect);
            Aroma spisok = new Aroma();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok = new Aroma(reader.GetInt32(0), reader.GetString(1),
                        reader.GetString(2), reader.GetString(3), reader.GetInt32(4), reader.GetInt32(5));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static List<Aroma> GetFavoriteAroma(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from GetFavoriteAroma(@id)", connect);
            List<Aroma> spisok = new List<Aroma>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Aroma(reader.GetInt32(0), reader.GetString(1),
                        reader.GetString(2), reader.GetString(3), reader.GetInt32(4), reader.GetInt32(5)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static List<Aroma> SearchAroma(int index, string aromasGroup, string type, string search)
        {
            if (aromasGroup == "" || aromasGroup == " " || aromasGroup == null)
            {
                aromasGroup = "%";
            }
            if (type == "" || type == " " || type == null)
            {
                type = "%";
            }
            if (search == "" || search == " " || search == null)
            {
                search = "%";
            }
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from SearchAroma(@aromasGroup,@type,@search)", connect);
            switch (index)
            {
                case 0: command.CommandText += " order by Aroma asc"; break;
                case 1: command.CommandText += " order by MinPrice asc"; break;
                case 2: command.CommandText += " order by MinPrice desc"; break;
                default: command.CommandText += " order by Aroma asc"; break;
            }
            List<Aroma> spisok = new List<Aroma>();
            command.Parameters.AddWithValue("@aromasGroup", aromasGroup);
            command.Parameters.AddWithValue("@type", type);
            command.Parameters.AddWithValue("@search", search);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Aroma(reader.GetInt32(0), reader.GetString(1),
                        reader.GetString(2), reader.GetString(3), reader.GetInt32(4), reader.GetInt32(5)));
                }
                //MessageBox.Show($"{index}\t{aromasGroup}\t{type}\t{search}");
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
