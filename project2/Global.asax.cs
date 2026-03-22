using System;
using System.Data.SqlClient;
using System.Web;

namespace project2
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Initialize Application state variables
            Application.Lock();
            Application["SessionsNum"] = 0;
            Application["LoginSessions"] = 0;
            Application["currentSession"] = 0;
            Application["activeUsers"] = 0;
            Application["DebugInit"] = "Initialized at " + DateTime.Now.ToString();
            Application.UnLock();
            Application["DebugInit"] = "Application_Start called at " + DateTime.Now.ToString();
            try
            {
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["RecipesDBConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string checkSql = "SELECT COUNT(*) FROM tblUsers";
                    using (SqlCommand checkCmd = new SqlCommand(checkSql, conn))
                    {
                        if ((int)checkCmd.ExecuteScalar() > 0)
                        {
                            Application["DebugInit"] = Application["DebugInit"] + "; Users already exist";
                            return;
                        }
                    }

                    string insertSql = @"INSERT INTO tblUsers (Username, Password, FirstName, LastName, Email, BirthDate, City, Gender, Admin)
                                        VALUES (@Username, @Password, @FirstName, @LastName, @Email, @BirthDate, @City, @Gender, @Admin)";
                    using (SqlCommand cmd = new SqlCommand(insertSql, conn))
                    {
                        // User 1: Shelly12 (Admin)
                        cmd.Parameters.AddWithValue("@Username", "Shelly12");
                        cmd.Parameters.AddWithValue("@Password", "Shelly2008!");
                        cmd.Parameters.AddWithValue("@FirstName", "Shelly");
                        cmd.Parameters.AddWithValue("@LastName", "Cohen");
                        cmd.Parameters.AddWithValue("@Email", "shelly@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1990, 5, 10));
                        cmd.Parameters.AddWithValue("@City", "Nes Tziona");
                        cmd.Parameters.AddWithValue("@Gender", "Female");
                        cmd.Parameters.AddWithValue("@Admin", true);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 2: Yulie12 (Admin)
                        cmd.Parameters.AddWithValue("@Username", "Yulie12");
                        cmd.Parameters.AddWithValue("@Password", "Yule2010!");
                        cmd.Parameters.AddWithValue("@FirstName", "Yulie");
                        cmd.Parameters.AddWithValue("@LastName", "Smith");
                        cmd.Parameters.AddWithValue("@Email", "yulie@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1987, 3, 15));
                        cmd.Parameters.AddWithValue("@City", "Tel Aviv");
                        cmd.Parameters.AddWithValue("@Gender", "Female");
                        cmd.Parameters.AddWithValue("@Admin", true);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 3: Avigail1
                        cmd.Parameters.AddWithValue("@Username", "Avigail1");
                        cmd.Parameters.AddWithValue("@Password", "Avigail28!");
                        cmd.Parameters.AddWithValue("@FirstName", "Avigail");
                        cmd.Parameters.AddWithValue("@LastName", "Levy");
                        cmd.Parameters.AddWithValue("@Email", "avigail@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1995, 8, 20));
                        cmd.Parameters.AddWithValue("@City", "Nes Tziona");
                        cmd.Parameters.AddWithValue("@Gender", "Female");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 4: Ofri12
                        cmd.Parameters.AddWithValue("@Username", "Ofri12");
                        cmd.Parameters.AddWithValue("@Password", "Ofri2007!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 5: Emily12
                        cmd.Parameters.AddWithValue("@Username", "Emily12");
                        cmd.Parameters.AddWithValue("@Password", "Emily1200!");
                        cmd.Parameters.AddWithValue("@FirstName", "Emily");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "Emily@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1988, 1, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Female");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 6: Luke12
                        cmd.Parameters.AddWithValue("@Username", "Luke12");
                        cmd.Parameters.AddWithValue("@Password", "Luke1200!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 7: Lucy12
                        cmd.Parameters.AddWithValue("@Username", "Ofri12");
                        cmd.Parameters.AddWithValue("@Password", "Ofri2007!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 8: Yael13
                        cmd.Parameters.AddWithValue("@Username", "Ofri12");
                        cmd.Parameters.AddWithValue("@Password", "Ofri2007!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 9: Yonatan15
                        cmd.Parameters.AddWithValue("@Username", "Ofri12");
                        cmd.Parameters.AddWithValue("@Password", "Ofri2007!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        // User 10: Elan15
                        cmd.Parameters.AddWithValue("@Username", "Ofri12");
                        cmd.Parameters.AddWithValue("@Password", "Ofri2007!");
                        cmd.Parameters.AddWithValue("@FirstName", "Ofri");
                        cmd.Parameters.AddWithValue("@LastName", "Rabin");
                        cmd.Parameters.AddWithValue("@Email", "ofri@example.com");
                        cmd.Parameters.AddWithValue("@BirthDate", new DateTime(1998, 11, 5));
                        cmd.Parameters.AddWithValue("@City", "Jerusalem");
                        cmd.Parameters.AddWithValue("@Gender", "Male");
                        cmd.Parameters.AddWithValue("@Admin", false);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();


                    }
                    Application["DebugInit"] = Application["DebugInit"] + "; Users inserted successfully";
                }
            }
            catch (Exception ex)
            {
                Application["DebugInit"] = Application["DebugInit"] + "; User insert failed: " + ex.Message;
            }
        }
        protected void Session_Start(object sender, EventArgs e)
        {
            // Increment session counter
            Application.Lock();
            Application["SessionsNum"] = (int)Application["SessionsNum"] + 1;
            Application["currentSession"] = (int)Application["currentSession"] + 1;
            Application.UnLock();
        }

        protected void Session_End(object sender, EventArgs e)
        {
            // Decrement session counter
            Application.Lock();
            Application["currentSession"] = (int)Application["currentSession"] - 1;
            if (Session["Login"] != null && (bool)Session["Login"])
            {
                Application["activeUsers"] = (int)Application["activeUsers"] - 1;
            }
            Application.UnLock();
        }

    }

}