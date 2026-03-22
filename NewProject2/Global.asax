<%@ Application Language="C#" %>

<script runat="server">
    void Application_Start(object sender, EventArgs e)
    {
        // Initialize application variables
        Application["TotalVisits"] = 0;
        Application["RegisteredVisits"] = 0;
        Application["OnlineGuests"] = 0;
        Application["OnlineRegistered"] = 0;
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Initialize session variables
        Session["login"] = false;
        Session["UserType"] = project2.UserType.Guest;
        Session["Username"] = "Guest";
        
        // Increment total visits
        Application.Lock();
        Application["TotalVisits"] = (int)Application["TotalVisits"] + 1;
        Application["OnlineGuests"] = (int)Application["OnlineGuests"] + 1;
        Application.UnLock();
    }

    void Session_End(object sender, EventArgs e)
    {
        Application.Lock();
        if ((project2.UserType)Session["UserType"] != project2.UserType.Guest)
        {
            Application["OnlineRegistered"] = (int)Application["OnlineRegistered"] - 1;
        }
        else
        {
            Application["OnlineGuests"] = (int)Application["OnlineGuests"] - 1;
        }
        Application.UnLock();
    }
</script>
