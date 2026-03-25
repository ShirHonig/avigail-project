using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace project2
{
    public partial class master2 : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["RecipesDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Redirect if already logged in
                if (Session["Login"] != null && (bool)Session["Login"])
                {
                    Response.Redirect("Main.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check for existing username
                    string checkQuery = "SELECT COUNT(*) FROM tblUsers WHERE Username = @Username";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    conn.Open();
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        message.Text = "Username already exists.";
                        return;
                    }
                    conn.Close();

                    // Insert new user
                    string query = "INSERT INTO tblUsers (Username, Password, FirstName, LastName, Email, BirthDate, City, Gender, Admin) " +
                                   "VALUES (@Username, @Password, @FirstName, @LastName, @Email, @BirthDate, @City, @Gender, @Admin)";
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@BirthDate", txtBirthDate.Text);
                    cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(txtCity.Text) ? (object)DBNull.Value : txtCity.Text);
                    cmd.Parameters.AddWithValue("@Gender", rblGender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Admin", false);
                    adapter.InsertCommand = cmd;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    message.Text = "User registered successfully!";
                    Session["Login"] = true;
                    Session["userName"] = txtUsername.Text;
                    Session["Admin"] = false;
                    Response.Redirect("Main.aspx");
                }
            }
            catch (SqlException ex)
            {
                message.Text = "Error: " + ex.Message;
            }
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Handled client-side by resetForm()
        }
    }
}