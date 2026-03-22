using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["userN"] = "Visitor";
            Session["Login"] = false;
            Session["Admin"] = false;
            Application["ActiveUsers"] = (int)Application["ActiveUsers"] - 1;
            Response.Redirect("/Main.aspx");
        }
    }
}