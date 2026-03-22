using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class AdminUsers : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\RecipesDB.mdf;Integrated Security=True"; protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Login"] == null || !(bool)Session["Login"] || Session["Admin"] == null || !(bool)Session["Admin"])
                {
                    message.Text = "Access denied. Admins only.";
                    gvUsers.Visible = false;
                    btnDeleteSelected.Visible = false;
                    return;
                }
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
                    if (ViewState["SortDirection"]?.ToString() == "ASC")
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
            ViewState["SortDirection"] = ViewState["SortDirection"]?.ToString() == "ASC" ? "DESC" : "ASC";
            LoadUsers(sortExpression);
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            if (Session["Login"] == null || !(bool)Session["Login"] || Session["Admin"] == null || !(bool)Session["Admin"])
            {
                message.Text = "Access denied. Admins only.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                string query = "DELETE FROM tblUsers WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.Add("@UserId", SqlDbType.Int);
                adapter.DeleteCommand = cmd;
                conn.Open();
                foreach (GridViewRow row in gvUsers.Rows)
                {
                    CheckBox chkDelete = (CheckBox)row.FindControl("chkDelete");
                    if (chkDelete.Checked)
                    {
                        int userId = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);
                        cmd.Parameters["@UserId"].Value = userId;
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            LoadUsers();
        }
    }
}