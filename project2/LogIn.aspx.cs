using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace project2
{
    public partial class login : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\RecipesDB.mdf;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Generate anti-forgery token
                var token = Guid.NewGuid().ToString();
                Session["AntiForgeryToken"] = token;
                hfAntiForgery.Value = token;
                Session["LoginAttempts"] = 0;

                // Redirect if already logged in
                if (Session["Login"] != null && (bool)Session["Login"])
                {
                    Response.Redirect("Main.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Verify anti-forgery token
            if (hfAntiForgery.Value != Session["AntiForgeryToken"]?.ToString())
            {
                message.Text = "Invalid form submission.";
                return;
            }

            // Check login attempts
            int attempts = (int)(Session["LoginAttempts"] ?? 0);
            if (attempts >= 5)
            {
                message.Text = "Too many failed attempts. Please recover your password.";
                btnSubmit.Enabled = false;
                Response.Redirect("PasswordRecovery.aspx");
                return;
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Server-side validation (reusing your logic)
            if (username.Length < 2)
            {
                message.Text = "Username must be at least 2 characters.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(username, @"^[a-zA-Z][a-zA-Z0-9@_.-]*$"))
            {
                message.Text = "Username must start with a letter and contain only letters, numbers, @, _, ., or -.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (password.Length < 6 || password.Length > 12)
            {
                message.Text = "Password must be 6-12 characters.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':""/|,.<>/?]*$"))
            {
                message.Text = "Password can only contain English letters, numbers, or common special characters.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]"))
            {
                message.Text = "Password must have at least one uppercase letter.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[0-9]"))
            {
                message.Text = "Password must have at least one number.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[!@#$%^&*()_+\-=\[\]{};':""/|,.<>/?]"))
            {
                message.Text = "Password must have at least one special character.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }
            if (System.Text.RegularExpressions.Regex.IsMatch(password, @"(.)\1{2,}"))
            {
                message.Text = "Password cannot contain 3 or more consecutive repeating characters.";
                Session["LoginAttempts"] = attempts + 1;
                return;
            }

            // Authenticate against tblUsers
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT UserId, Admin FROM tblUsers WHERE Username = @Username AND Password = @Password";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["Login"] = true;
                        Session["userName"] = username;
                        Session["UserId"] = reader["UserId"];
                        Session["Admin"] = Convert.ToBoolean(reader["Admin"]);
                        Session["LoginAttempts"] = 0;
                        Response.Redirect("Main.aspx");
                    }
                    else
                    {
                        Session["LoginAttempts"] = attempts + 1;
                        message.Text = "Invalid username or password.";
                    }
                }
            }
            catch (SqlException ex)
            {
                message.Text = "Error: " + ex.Message;
            }
        }
    }
}