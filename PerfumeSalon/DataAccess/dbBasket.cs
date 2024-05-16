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
    public class dbBasket
    {
        public static List<Product> GetProductFromBasket(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from GetProductFromBasket(@id)", connect);
            List<Product> products = new List<Product>();
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        products.Add(new Product(reader.GetInt32(0), reader.GetString(1),
                            reader.GetString(2), reader.GetString(3), reader.GetInt32(4),
                            reader.GetInt32(5), reader.GetInt32(6)));
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
        public static int GetAromaIdFromProduct(int id)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select A.id from Aroma A" +
                " join Product P on P.Aroma = A.id" +
                " where P.id = @id", connect);
            int aromaId = 0;
            command.Parameters.AddWithValue("@id", id);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        aromaId = reader.GetInt32(0);
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return aromaId;
        }
        public static void AddProductToBasket(int userId, int productId)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec AddProductToBasket @userId, @productId", connect);
            command.Parameters.AddWithValue("@userId", userId);
            command.Parameters.AddWithValue("@productId", productId);
            try
            {
                connect.Open();
                command.ExecuteNonQuery();
                MessageBox.Show("Продукт добавлен в корзину!");
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public static void DeleteProductFromBasket(int userId, int productId)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec DeleteFromBasket @userId, @productId", connect);
            command.Parameters.AddWithValue("@userId", userId);
            command.Parameters.AddWithValue("@productId", productId);
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
    }
}
