using System;
using System.Web.UI;

namespace project2
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set welcome message based on user type
                string username = Session["Username"]?.ToString() ?? "Guest";
                UserType userType = Session["UserType"] != null ? (UserType)Session["UserType"] : UserType.Guest;

                switch (userType)
                {
                    case UserType.Admin:
                        lblWelcome.Text = $"Welcome {username} - Administrator";
                        break;
                    case UserType.RegisteredUser:
                        lblWelcome.Text = $"Welcome {username}";
                        break;
                    default:
                        lblWelcome.Text = "Welcome to the Recipe Website";
                        pnlGuest.Visible = true;
                        break;
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Register.aspx");
        }
    }
} 