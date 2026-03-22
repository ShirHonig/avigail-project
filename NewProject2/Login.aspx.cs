using System;
using System.Web.UI;

namespace project2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already logged in, redirect to home page
            if (Session["UserType"] != null && (UserType)Session["UserType"] != UserType.Guest)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            UserType userType;
            if (UserManagement.ValidateUser(username, password, out userType))
            {
                // Update session variables
                Session["login"] = true;
                Session["UserType"] = userType;
                Session["Username"] = username;

                // Update application statistics
                Application.Lock();
                Application["RegisteredVisits"] = (int)Application["RegisteredVisits"] + 1;
                Application["OnlineGuests"] = (int)Application["OnlineGuests"] - 1;
                Application["OnlineRegistered"] = (int)Application["OnlineRegistered"] + 1;
                Application.UnLock();

                // Redirect to home page
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                // Show error message
                lblError.Text = "Invalid username or password";
                lblError.Visible = true;
            }
        }
    }
} 