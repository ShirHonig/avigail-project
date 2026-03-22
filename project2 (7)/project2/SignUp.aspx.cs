using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class master2 : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (Request.Form["userN"]=="Shelly.2008!" && Request.Form["password"] == "Password1!.")
                {
                    Session["username"] = Request.Form["userN"];
                    Session["login"] = true;
                    Session["admin"] = false;
                    div.InnerHtml = "";
                    Response.Redirect("/master4.aspx");

                }
                else
                {
                    Session["username"] = "visitor";
                    Session["login"] = true;
                    div.InnerHtml = "unknown username or password";
                       
                }
            }
        }
    }
}
