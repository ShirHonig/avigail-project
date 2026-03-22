using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class Admin1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User1.InnerHtml = Application["userN"].ToString();
            Pass1.InnerHtml = Application["password"].ToString();
            Admin1Div.InnerHtml = Application["uAdmin1"].ToString();

            User2.InnerHtml = Application["userN"].ToString();
            Pass2.InnerHtml = Application["password"].ToString();
            Admin2.InnerHtml = Application["uAdmin2"].ToString();

            User3.InnerHtml = Application["userN"].ToString();
            Pass3.InnerHtml = Application["password"].ToString();
            Admin3.InnerHtml = Application["uAdmin3"].ToString();

            User4.InnerHtml = Application["userN"].ToString();
            Pass4.InnerHtml = Application["password"].ToString();
            Admin4.InnerHtml = Application["uAdmin4"].ToString();

            User5.InnerHtml = Application["userN"].ToString();
            Pass5.InnerHtml = Application["password"].ToString();
            Admin5.InnerHtml = Application["uAdmin5"].ToString();

        }
    }
}