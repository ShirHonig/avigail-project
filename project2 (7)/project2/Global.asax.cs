using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace project2
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Initialize credentials
            Application["uName1"] = "Shelly12";
            Application["uPass1"] = "Shelly2008!";
            Application["uAdmin1"] = true;

            Application["uName2"] = "Yulie12";
            Application["uPass2"] = "Yule2010!";
            Application["uAdmin2"] = true;

            Application["uName3"] = "Avigail1";
            Application["uPass3"] = "Avigail28!";
            Application["uAdmin3"] = false;

            Application["uName4"] = "Ofri12";
            Application["uPass4"] = "Ofri2007!";
            Application["uAdmin4"] = false;

            Application["uName5"] = "May12";
            Application["uPass5"] = "May2008!";
            Application["uAdmin5"] = false;

            Application["SessionsNum"] = 0; // Total visitors
            Application["currentSession"] = 0; // Total current sessions
            Application["ActiveUsers"] = 0; // Total current login
            Application["LoginSessions"] = 0; // Total login visitors
            Application["DebugInit"] = "Application_Start called at " + DateTime.Now.ToString(); // Debug flag with timestamp
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["userName"] = "Visitor";
            Session["Login"] = false;
            Session["Admin"] = false;

            Application.Lock();
            Application["SessionsNum"] = (int)Application["SessionsNum"] + 1;
            Application["currentSession"] = (int)Application["currentSession"] + 1;
            Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application.Lock();
            Application["currentSession"] = (int)Application["currentSession"] - 1;
            if (Session["userName"] != null && Session["userName"].ToString() != "Visitor")
            {
                Application["ActiveUsers"] = (int)Application["ActiveUsers"] - 1;
            }
            Application.UnLock();
        }

        protected void Application_End(object sender, EventArgs e)
        {
        }
    }
}