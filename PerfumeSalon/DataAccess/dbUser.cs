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
    public class dbUser
    {
        public static void RegisterNewUser(string login, string password, string f, string m, string l, string email, string phone)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from IsLoginTaken(@login)", connect);
            command.Parameters.AddWithValue("@login", login);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (!reader.HasRows)
                {
                    reader.Close();
                    SqlCommand commandEmail = new SqlCommand("select * from IsEmailTaken(@email)", connect);
                    commandEmail.Parameters.AddWithValue("@email",email);
                    SqlDataReader readerEmail = commandEmail.ExecuteReader();
                    if (!readerEmail.HasRows)
                    {
                        readerEmail.Close();
                        SqlCommand commandPhone = new SqlCommand("select * from IsPhoneTaken(@phone)", connect);
                        commandPhone.Parameters.AddWithValue("@phone", phone);
                        SqlDataReader readerPhone = commandPhone.ExecuteReader();
                        if (!readerPhone.HasRows)
                        {
                            readerPhone.Close();
                            SqlCommand command1 = new SqlCommand("exec RegisterNewUser @login, @password," +
                        " @f, @m, @l, @email, @phone", connect);
                            command1.Parameters.AddWithValue("@login", login);
                            command1.Parameters.AddWithValue("@password", password);
                            command1.Parameters.AddWithValue("@f", f);
                            command1.Parameters.AddWithValue("@m", m);
                            command1.Parameters.AddWithValue("@l", l);
                            command1.Parameters.AddWithValue("@email", email);
                            command1.Parameters.AddWithValue("@phone", phone);
                            command1.ExecuteNonQuery();
                            MessageBox.Show("Регистрация прошла успешно");
                        }
                        else
                        {
                            MessageBox.Show("Этот номер телефона занят");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Этот адрес эл. почты занят");
                    }
                }
                else
                {
                    MessageBox.Show("Этот логин занят");
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public static User Login(string login, string password)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from User" +
                " where Login = @login", connect);
            User user = new User();
            command.Parameters.AddWithValue("@login", login);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Close();
                    SqlCommand command1 = new SqlCommand("select * from User" +
                        " where Login = @login and Password = @password", connect);
                    command1.Parameters.AddWithValue("@login", login);
                    command1.Parameters.AddWithValue("@password", password);
                    SqlDataReader reader1 = command1.ExecuteReader();
                    if (reader1.HasRows)
                    {
                        while (reader1.Read())
                        {
                            user = new User(reader1.GetInt32(0), reader1.GetString(1), reader1.GetString(2), reader1.GetInt32(3));
                        }
                        MessageBox.Show("Авторизация прошла успешно");
                    }
                    else
                    {
                        MessageBox.Show("Неверный пароль");
                    }
                }
                else
                {
                    MessageBox.Show("Неверный логин");
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return user;
        }
        public static Profile GetProfileByUserId(int userId)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("select * from GetProfileByUserId(@userId)", connect);
            Profile profile = new Profile();
            command.Parameters.AddWithValue("@userId", userId);
            try
            {
                connect.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    profile = new Profile(reader.GetString(0), reader.GetString(1),
                        reader.GetInt32(2), reader.GetString(3), reader.GetString(4),
                        reader.GetString(5), reader.GetString(6), reader.GetString(7));
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return profile;
        }
        public static void EditProfile(int id, string login, string password, string f, string m, 
            string l, string email, string phone)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec EditUser @id, @login, @password," +
                " @f, @m, @l, @email, @phone"
                , connect);
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@login", login);
            command.Parameters.AddWithValue("@password", password);
            command.Parameters.AddWithValue("@f", f);
            command.Parameters.AddWithValue("@m", m);
            command.Parameters.AddWithValue("@l", l);
            command.Parameters.AddWithValue("@email", email);
            command.Parameters.AddWithValue("@phone", phone);
            try
            {
                connect.Open();
                command.ExecuteNonQuery();
                MessageBox.Show("Данные изменены");
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public static void EditProfileWithoutPassword(int id, string f, string m,
            string l, string email, string phone)
        {
            SqlConnection connect = new SqlConnection(Connection.connectionString);
            SqlCommand command = new SqlCommand("exec EditUserWithoutPassword @id," +
                " @f, @m, @l, @email, @phone"
                , connect);
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@f", f);
            command.Parameters.AddWithValue("@m", m);
            command.Parameters.AddWithValue("@l", l);
            command.Parameters.AddWithValue("@email", email);
            command.Parameters.AddWithValue("@phone", phone);
            try
            {
                connect.Open();
                command.ExecuteNonQuery();
                MessageBox.Show("Данные изменены");
                connect.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
