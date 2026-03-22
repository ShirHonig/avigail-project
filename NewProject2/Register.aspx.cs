using System;
using System.Web.UI;
using System.Linq;

namespace project2
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already logged in, redirect to home page
            if (Session["UserType"] != null && (UserType)Session["UserType"] != UserType.Guest)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            // Check if username already exists
            if (UserManagement.Users.Any(u => u.Username == username))
            {
                lblError.Text = "Username already exists";
                lblError.Visible = true;
                return;
            }

            // Add new user
            UserManagement.Users.Add(new User
            {
                Username = username,
                Password = password,
                UserType = UserType.RegisteredUser
            });

            // Show success message
            lblSuccess.Text = "Registration successful! You will be redirected to the login page.";
            lblSuccess.Visible = true;
            lblError.Visible = false;

            // Clear form
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";

            // Redirect to login page after 3 seconds
            string script = "setTimeout(function() { window.location = 'Login.aspx'; }, 3000);";
            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", script, true);
        }
    }
} 