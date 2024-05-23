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
    class dbProduct
    {
        public static List<Product> LoadProductByAromaId(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select P.[id],[Type],[Category],A.[Aroma],V.[Volume],[Price]" +
                " from Product P join Aroma A on A.id = P.Aroma" +
                " join ProductType PT on PT.id = P.ProductType" +
                " join ProductCategory PC on PC.id = P.ProductCategory" +
                " join Volume V on V.id = P.Volume" +
                " where A.id = @id", connect);
            List<Product> spisok = new List<Product>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Product(reader.GetInt32(0), reader.GetString(1),
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
        public static List<Volume> LoadVolumeByAromaId(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select V.[id],V.[Volume] from Volume V" +
                " join Product P on P.Volume = V.id" +
                " join Aroma A on A.id = P.Aroma" +
                " where A.id = @id", connect);
            List<Volume> spisok = new List<Volume>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new Volume(reader.GetInt32(0), reader.GetInt32(1)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static List<NoteInAroma> LoadNotesByAromaId(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select NC.id, N.Note from [dbo].[NoteInAroma] NA" +
                " join [dbo].[Aroma] A on A.id = NA.Aroma" +
                " join [dbo].[NoteClass] NC on NC.id = NA.NoteClass" +
                " join Note N on N.id = NA.Note" +
                " where A.id = @id", connect);
            List<NoteInAroma> spisok = new List<NoteInAroma>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    spisok.Add(new NoteInAroma(reader.GetInt32(0), reader.GetString(1)));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return spisok;
        }
        public static int GetPriceByVolume(int id, int volume)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select Price from Product P" +
                " join Volume V on V.id = P.Volume" +
                " where Aroma = @id" +
                " and V.Volume = @volume", connect);
            int price = 0;
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@volume", volume);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        price = reader.GetInt32(0);
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return price;
        }
        public static string GetDescriptionByAromaId(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select Description from Aroma" +
                " where id = @id", connect);
            string description = "";
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        description = reader.GetString(0);
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return description;
        }
        public static List<int> GetProductIdFromFavorites(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from GetProductIdFromFavorite(@id)", connect);
            List<int> products = new List<int>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        products.Add(reader.GetInt32(0));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return products;
        }
        public static List<string> GetAromaFromFavorites(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from GetAromaFromFavorite(@id)", connect);
            List<string> aromas = new List<string>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        aromas.Add(reader.GetString(0));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return aromas;
        }
        public static void ChangeMark(int userId, string aroma)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec MarkAsFavorite @userId, @aroma", connect);
            command.Parameters.AddWithValue("@userId", userId);
            command.Parameters.AddWithValue("@aroma", aroma);
            try
            {
                connect.Open();
                command.ExecuteNonQuery();
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public static List<string> GetProductTypes()
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select Type from ProductType", connect);
            List<string> types = new List<string>();
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        types.Add(reader.GetString(0));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return types;
        }

        public static List<ProductType> LoadProductTypeToComboBox()
        {
            List<ProductType> types = new List<ProductType>();
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select id, Type from ProductType", connect);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        types.Add(new ProductType(reader.GetInt32(0), reader.GetString(1)));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return types;
        }

        public static List<ProductCategory> LoadProductCategoryToComboBox()
        {
            List<ProductCategory> categories = new List<ProductCategory>();
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select id, Category from ProductCategory", connect);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        categories.Add(new ProductCategory(reader.GetInt32(0), reader.GetString(1)));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return categories;
        }

        public static List<Volume> LoadVolumeToComboBox()
        {
            List<Volume> volumes = new List<Volume>();
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select id, Volume from Volume", connect);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        volumes.Add(new Volume(reader.GetInt32(0), reader.GetInt32(1)));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return volumes;
        }

        public static void AddProductToAroma(int type, int category, int aroma, int volume, int price)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec AddProductToAroma @type, @category, @aroma, " +
                "@volume, @price", connect);
            command.Parameters.AddWithValue("@type",type);
            command.Parameters.AddWithValue("@category", category);
            command.Parameters.AddWithValue("@aroma", aroma);
            command.Parameters.AddWithValue("@volume", volume);
            command.Parameters.AddWithValue("@price", price);
            try
            {
                connect.Open();
                command.ExecuteNonQuery();
                MessageBox.Show("Продукт добавлен");
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

    }
}
