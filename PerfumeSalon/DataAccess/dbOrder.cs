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
    class dbOrder
    {
        public static void CreateOrder(int userId, DateTime date, string address)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec CreateOrder @userId, @date, @address", connect);
            command.Parameters.AddWithValue("@userId", userId);
            command.Parameters.AddWithValue("@date", date);
            command.Parameters.AddWithValue("@address", address);
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
        public static int GetLastOrderId(int userId, string address)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select Top(1) O.id from Order O" +
                " join Customer C on C.id = O.Customer" +
                " join User U on U.id = C.Login" +
                " where U.id = @userId" +
                " and O.Address = @address" +
                " group by O.id" +
                " order by O.id desc", connect);
            command.Parameters.AddWithValue("@userId", userId);
            command.Parameters.AddWithValue("@address", address);
            int orderId = 0;
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        orderId = reader.GetInt32(0);
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return orderId;
        }
        public static void CreateOrderInfo(int orderId, int productId, int quantity)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec CreateOrderInfo @orderId, @productId, @quantity", connect);
            command.Parameters.AddWithValue("@orderId", orderId);
            command.Parameters.AddWithValue("@productId", productId);
            command.Parameters.AddWithValue("@quantity", quantity);
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
        public static List<Order> ShowOrder(int userId)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from ShowOrder(@userId)", connect);
            List<Order> orders = new List<Order>();
            command.Parameters.AddWithValue("@userId", userId);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        orders.Add(new Order(reader.GetInt32(0), reader.GetDateTime(1), reader.GetString(2), reader.GetInt32(3)));
                    }
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return orders;
        }
        public static List<Product> ShowOrderInfo(int orderId)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from ShowOrderInfo(@orderId)", connect);
            List<Product> products = new List<Product>();
            command.Parameters.AddWithValue("@orderId", orderId);
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
    }
}
