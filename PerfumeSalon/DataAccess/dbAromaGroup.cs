using PerfumeSalon.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

namespace PerfumeSalon.Classes
{
    internal class dbAromaGroup
    {
        public static List<AromaGroup> LoadFromDB()
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select [id],AG.[AromaGroup],[Image],count([Aroma]) from [dbo].[AromaGroup] AG" +
                " left join [dbo].[AromaGroupInAroma] AGA on AGA.AromaGroup = AG.id" +
                " group by [id],AG.[AromaGroup],[Image]", connect);
            List<AromaGroup> spisok = new List<AromaGroup>();
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new AromaGroup(reader.GetInt32(0), reader.GetString(1), 
                        new Uri(reader.GetString(2), UriKind.Relative), reader.GetInt32(3)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static List<string> GetAromaGroupByAromaId(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select AG.[AromaGroup] from AromaGroup AG" +
                " join AromaGroupInAroma AGA on AGA.AromaGroup = AG.id" +
                " join Aroma A on A.id = AGA.Aroma" +
                " where A.id = @id", connect);
            command.Parameters.AddWithValue("@id",id);
            List<string> spisok = new List<string>();
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(reader.GetString(0));
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
