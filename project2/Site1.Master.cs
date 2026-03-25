using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace project2
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool isLoggedIn = Session["Login"] != null && (bool)Session["Login"];
                bool isAdmin = Session["Admin"] != null && (bool)Session["Admin"];
                string username = Session["userName"]?.ToString() ?? "Guest";

                // Set menu visibility
                guestMenu.Visible = !isLoggedIn;
                userMenu.Visible = isLoggedIn && !isAdmin;
                adminMenu.Visible = isLoggedIn && isAdmin;

                // Set username labels
                lblUsername.Text = username;
                lblAdminUsername.Text = username;

                // Control nav links visibility
                Recipes.Visible = isLoggedIn; // Dropdown parent (Workouts)
                RecipesItem.Visible = isLoggedIn; // All Workouts in dropdown
                Muffins.Visible = isLoggedIn;
                Cookies.Visible = isLoggedIn;
                Brownies.Visible = isLoggedIn;
                Rolls.Visible = isLoggedIn;
                Soufle.Visible = isLoggedIn;
                Logout.Visible = isLoggedIn;
                Sessions.Visible = isAdmin;
                UsersTable.Visible = isAdmin;
                UpdateUser.Visible = isLoggedIn;
                PasswordRecovery.Visible = !isLoggedIn;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Main.aspx");
        }
    }
}