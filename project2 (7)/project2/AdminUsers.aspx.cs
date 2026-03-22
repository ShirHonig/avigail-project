using System;
using System.Collections.Generic;
using System.Web.UI;

namespace project2.Admin
{
    public partial class AdminUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is admin
                bool isAdmin = Session["Admin"] != null && (bool)Session["Admin"];
                if (!isAdmin)
                {
                    Response.Redirect("~/LogIn.aspx");
                    return;
                }

                // Bind users to grid
                try
                {
                    var users = new List<object>();
                    for (int i = 1; i <= 5; i++)
                    {
                        string username = Application[$"uName{i}"]?.ToString();
                        string password = Application[$"uPass{i}"]?.ToString();
                        bool? isAdminUser = Application[$"uAdmin{i}"] as bool?;

                        if (!string.IsNullOrEmpty(username))
                        {
                            users.Add(new
                            {
                                Username = username,
                                Password = password,
                                IsAdmin = isAdminUser
                            });
                        }
                    }

                    gvUsers.DataSource = users;
                    gvUsers.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error loading users: {ex.Message}";
                }
            }
        }
    }
}