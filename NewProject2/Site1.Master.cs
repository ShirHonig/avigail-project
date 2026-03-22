using System;
using System.Web.UI;

namespace project2
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateMenuVisibility();
            }
        }

        private void UpdateMenuVisibility()
        {
            string username = Session["Username"]?.ToString() ?? "Guest";
            UserType userType = Session["UserType"] != null ? (UserType)Session["UserType"] : UserType.Guest;
            bool isLoggedIn = Session["login"] != null && (bool)Session["login"];

            lblUsername.Text = username;
            btnLogout.Visible = isLoggedIn;

            // Hide all menus first
            guestMenu.Visible = false;
            userMenu.Visible = false;
            adminMenu.Visible = false;

            // Show appropriate menu based on user type
            switch (userType)
            {
                case UserType.Admin:
                    adminMenu.Visible = true;
                    break;
                case UserType.RegisteredUser:
                    userMenu.Visible = true;
                    break;
                default:
                    guestMenu.Visible = true;
                    break;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            bool wasLoggedIn = Session["login"] != null && (bool)Session["login"];

            // Clear session
            Session.Clear();
            Session["UserType"] = UserType.Guest;
            Session["Username"] = "Guest";
            Session["login"] = false;

            // Update online users count
            if (wasLoggedIn)
            {
                Application.Lock();
                int registeredCount = (int)Application["OnlineRegistered"];
                if (registeredCount > 0)
                {
                    Application["OnlineRegistered"] = registeredCount - 1;
                }
                Application["OnlineGuests"] = (int)Application["OnlineGuests"] + 1;
                Application.UnLock();
            }

            // Redirect to home page
            Response.Redirect("~/Default.aspx");
        }
    }
}