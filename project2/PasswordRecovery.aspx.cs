using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace project2
{
    public partial class PasswordRecovery : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["RecipesDBConnection"].ConnectionString;
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE tblUsers SET Password = @NewPassword WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@NewPassword", txtNewPassword.Text);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        message.Text = "Password updated successfully! You can now log in.";
                        Session["LoginAttempts"] = 0; // Reset login attempts
                    }
                    else
                    {
                        message.Text = "Email not found.";
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