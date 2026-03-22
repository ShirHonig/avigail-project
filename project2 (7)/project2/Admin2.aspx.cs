using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class Admin2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Sessions.InnerHtml = "Total number of site visits: " + Application["SessionsNum"].ToString() + "<br>" +
                                 "Total registered visits: " + Application["LoginSessions"].ToString() + "<br>" +
                                 "Total current active users: " + Application["currentSession"].ToString() + "<br>" +
                                 "Total current registered users: " + Application["activeUsers"].ToString() + "<br>" +
                                 "Total current visitors: " + ((int)(Application["currentSession"]) - (int)(Application["activeUsers"])).ToString();
        }
    }
}