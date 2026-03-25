using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace project2
{
    public partial class UpdateUser : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["RecipesDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Login"] == null || !(bool)Session["Login"])
                {
                    message.Text = "Please log in to update user details.";
                    btnSubmit.Visible = false;
                    return;
                }

                int userId;
                if (!int.TryParse(Request.QueryString["UserId"], out userId))
                {
                    if (Session["UserId"] == null || !int.TryParse(Session["UserId"].ToString(), out userId))
                    {
                        message.Text = "Invalid user ID.";
                        btnSubmit.Visible = false;
                        return;
                    }
                }

                if (userId != Convert.ToInt32(Session["UserId"]) && (Session["Admin"] == null || !(bool)Session["Admin"]))
                {
                    message.Text = "Access denied. You can only update your own details.";
                    btnSubmit.Visible = false;
                    return;
                }

                if (Session["Admin"] != null && (bool)Session["Admin"])
                {
                    chkAdmin.Visible = true;
                }

                LoadUser(userId);
            }
        }

        private void LoadUser(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM tblUsers WHERE UserId = @UserId";
                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                adapter.SelectCommand.Parameters.AddWithValue("@UserId", userId);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    txtUsername.Text = row["Username"].ToString();
                    txtPassword.Text = row["Password"].ToString();
                    txtConfirmPassword.Text = row["Password"].ToString();
                    txtFirstName.Text = row["FirstName"].ToString();
                    txtLastName.Text = row["LastName"].ToString();
                    txtEmail.Text = row["Email"].ToString();
                    txtBirthDate.Text = Convert.ToDateTime(row["BirthDate"]).ToString("yyyy-MM-dd");
                    txtCity.Text = row["City"].ToString();
                    rblGender.SelectedValue = row["Gender"].ToString();
                    chkAdmin.Checked = Convert.ToBoolean(row["Admin"]);
                    Session["UserId"] = row["UserId"];
                }
                else
                {
                    message.Text = "User not found.";
                    btnSubmit.Visible = false;
                }
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check for existing username (excluding current user)
                    string checkQuery = "SELECT COUNT(*) FROM tblUsers WHERE Username = @Username AND UserId != @UserId";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    checkCmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        message.Text = "Username already exists.";
                        return;
                    }
                    conn.Close();

                    // Update user
                    string query = "UPDATE tblUsers SET Username = @Username, Password = @Password, FirstName = @FirstName, " +
                                   "LastName = @LastName, Email = @Email, BirthDate = @BirthDate, City = @City, " +
                                   "Gender = @Gender, Admin = @Admin WHERE UserId = @UserId";
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
                    cmd.Parameters.AddWithValue("@Admin", chkAdmin.Checked);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    adapter.UpdateCommand = cmd;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    message.Text = "User updated successfully!";
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