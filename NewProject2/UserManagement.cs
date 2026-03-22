using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;

namespace project2
{
    public class User
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public UserType UserType { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActive { get; set; }
    }

    public static class UserManagement
    {
        public static List<User> Users { get; private set; } = new List<User>();

        static UserManagement()
        {
            // Add default admin user
            Users.Add(new User
            {
                Username = "admin",
                Password = "Admin123!", // In production, this should be hashed
                UserType = UserType.Admin,
                CreatedDate = DateTime.Now,
                IsActive = true
            });
        }

        public static bool ValidateUser(string username, string password, out UserType userType)
        {
            userType = UserType.Guest;

            try
            {
                string connectionString = WebConfigurationManager.ConnectionStrings["UsersDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT UserType FROM tblUsers WHERE Username = @Username AND Password = @Password AND IsActive = 1", conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password); // In production, use proper password hashing

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            userType = (UserType)Convert.ToInt32(result);
                            return true;
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Fallback to in-memory user list if database is not available
                var user = Users.Find(u => u.Username == username && u.Password == password && u.IsActive);
                if (user != null)
                {
                    userType = user.UserType;
                    return true;
                }
            }

            return false;
        }
    }
} 