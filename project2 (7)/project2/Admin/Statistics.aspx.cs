using System;
using System.Web.UI;

namespace project2.Admin
{
    public partial class Statistics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is admin
                if (Session["UserType"] == null || (UserType)Session["UserType"] != UserType.Admin)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // Display statistics
                lblTotalVisits.Text = Application["TotalVisits"].ToString();
                lblRegisteredVisits.Text = Application["RegisteredVisits"].ToString();
                lblOnlineGuests.Text = Application["OnlineGuests"].ToString();
                lblOnlineRegistered.Text = Application["OnlineRegistered"].ToString();
                
                // Calculate total online users
                int totalOnline = (int)Application["OnlineGuests"] + (int)Application["OnlineRegistered"];
                lblTotalOnline.Text = totalOnline.ToString();
            }
        }
    }
} 