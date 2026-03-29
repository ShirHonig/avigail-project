using System;
using System.Web.UI;

namespace project2
{
    public partial class Admin2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null || !(bool)Session["Login"] || Session["Admin"] == null || !(bool)Session["Admin"])
            {
                Sessions.InnerHtml = "Access denied. Admins only.";
                return;
            }

            Application.Lock();
            if (Application["SessionsNum"] == null) Application["SessionsNum"] = 0;
            if (Application["LoginSessions"] == null) Application["LoginSessions"] = 0;
            if (Application["currentSession"] == null) Application["currentSession"] = 0;
            if (Application["activeUsers"] == null) Application["activeUsers"] = 0;
            Application.UnLock();

            Sessions.InnerHtml = "Total number of site visits: " + Application["SessionsNum"].ToString() + "<br>" +
                                 "Total registered visits: " + Application["LoginSessions"].ToString() + "<br>" +
                                 "Total current active users: " + Application["currentSession"].ToString() + "<br>" +
                                 "Total current registered users: " + Application["activeUsers"].ToString() + "<br>" +
                                 "Total current visitors: " + ((int)Application["currentSession"] - (int)Application["activeUsers"]).ToString();
        }
    }
}