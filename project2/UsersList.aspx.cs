using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace YourProjectName
{
    public partial class UsersList : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\RecipesDB.mdf;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null || !(bool)Session["Admin"])
            {
                lblError.Text = "Access denied. Admins only.";
                gvUsers.Visible = false;
                return;
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers(string sortExpression = null)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM tblUsers";
                string whereClause = "";
                if (!string.IsNullOrEmpty(txtUsernameFilter.Text) || !string.IsNullOrEmpty(txtFirstNameFilter.Text) || !string.IsNullOrEmpty(txtLastNameFilter.Text))
                {
                    whereClause = " WHERE ";
                    bool hasPreviousCondition = false;
                    if (!string.IsNullOrEmpty(txtUsernameFilter.Text))
                    {
                        whereClause += $"Username LIKE '%{txtUsernameFilter.Text}%'";
                        hasPreviousCondition = true;
                    }
                    if (!string.IsNullOrEmpty(txtFirstNameFilter.Text))
                    {
                        whereClause += hasPreviousCondition ? " OR " : "";
                        whereClause += $"FirstName LIKE '%{txtFirstNameFilter.Text}%'";
                        hasPreviousCondition = true;
                    }
                    if (!string.IsNullOrEmpty(txtLastNameFilter.Text))
                    {
                        whereClause += hasPreviousCondition ? " OR " : "";
                        whereClause += $"LastName LIKE '%{txtLastNameFilter.Text}%'";
                    }
                    query += whereClause;
                }

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    query += $" ORDER BY {sortExpression}";
                    if (ViewState["SortDirection"] != null && ViewState["SortDirection"].ToString() == "DESC")
                    {
                        query += " DESC";
                    }
                }

                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadUsers();
        }

        protected void gvUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;
            string sortDirection = ViewState["SortDirection"]?.ToString() == "ASC" ? "DESC" : "ASC";
            ViewState["SortDirection"] = sortDirection;
            LoadUsers(sortExpression);
        }
    }
}