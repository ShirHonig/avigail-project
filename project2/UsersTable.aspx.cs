using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace project2
{
    public partial class UsersTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
                if (!(bool)Session["Admin"])
                {
                    Response.Redirect("/Main.aspx");
                }

                if (!IsPostBack)
                {
                    string SQLStr = "select * from tblUsers";
                    DataSet ds = RetrieveUsersTable(SQLStr);
                    DataTable dt = ds.Tables[0];
                    string table = BuildUsersTable(dt);
                    tableDiv.InnerHtml = table;

                }

            }
        public DataSet RetrieveUsersTable(string SQLStr)
        {
            // Connect to Database
            //string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\lexte\OneDrive\Documents\Visual Studio 2022\SkiWebsite\SkiWebsite\App_Data\Database1.mdf"";Integrated Security=True";
            //SqlConnection con = new SqlConnection(connectionString);

            //Build SQL Query
            //SqlCommand cmd = new SqlCommand();
            //cmd.CommandText = SQLStr;
            //cmd.Connection = con;

            //Build DataAdapter
            // ad = new SqlDataAdapter(cmd);

            //Build dataset to store the data
            //DataSet ds = new DataSet();

            //Get the data from DataBase into the dataset
            //con.Open();
            //ad.Fill(ds, "users");
            //con.Close();


            return Helper.RetrieveTable(SQLStr);
        }

        public string BuildUsersTable(DataTable dt)
        {
            string str = "<Table class='usersTable' align='center' border=1>";
            str += "<tr><td></td>";
            foreach (DataColumn column in dt.Columns)
            {
                str += "<td>" + column.ColumnName + "</td>";
            }

            foreach (DataRow row in dt.Rows)
            {
                str += "<tr>";
                str += "<td>" + CreateRadioBtn(row["userId"].ToString()) + "</td>";
                foreach (DataColumn column in dt.Columns)
                {
                    str += "<td>" + row[column] + "</td>";
                }
                str += "</tr>";
            }
            str += "</tr>";
            str += "</Table>";
            return str;
        }
        public string BuildSQLStr(string str)
        {
            if (str.Length == 0)
            {
                return "SELECT * FROM tblUsers";
            }
            string SQLStr = $"SELECT * FROM tblUsers " +
            $"WHERE firstName LIKE '%{str}%' OR lastName LIKE '%{str}%' ";
            return SQLStr;
        }
        public void Click_Filter(object sender, EventArgs e)
        {
            string SQLStr = BuildSQLStr(Request.Form["filter"]);
            DataSet ds = RetrieveUsersTable(SQLStr);
            string table = BuildUsersTable(ds.Tables[0]);
            tableDiv.InnerHtml = table;
        }
        public void Click_Sort(object sender, EventArgs e)
        {
            string SQLStr = BuildSQLStr(Columns.SelectedValue, Request.Form["order"]);
            DataSet ds = RetrieveUsersTable(SQLStr);
            string table = BuildUsersTable(ds.Tables[0]);
            tableDiv.InnerHtml = table;
        }
        public string BuildSQLStr(string column, string order)
        {
            string SQLStr = $"SELECT * FROM tblUsers " +
                            $"ORDER BY {column} {order}";
            return SQLStr;
        }
        public string CreateRadioBtn(string id)
        {
            return $"<input type='checkbox' name='chk{id}' id='chk{id}' runat='server' />";
        }
        public void Delete(object sender, EventArgs e)
        {
            //string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\lexte\OneDrive\Documents\Visual Studio 2022\SkiWebsite\SkiWebsite\App_Data\Database1.mdf"";Integrated Security=True";
            SqlConnection con = new SqlConnection(Helper.conString);

            //load the data
            string SQLStr = "SELECT* FROM tblUsers";
            SqlCommand cmd = new SqlCommand(SQLStr, con);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "tblUsers");

            //delete chosen rows
            for (int i = 1; i < Request.Form.Count; i++)
            {
                if (Request.Form.AllKeys[i].Contains("chk"))
                {
                    int userId = int.Parse(Request.Form.AllKeys[i].Remove(0, 3));
                    DataRow[] dr = ds.Tables["tblUsers"].Select($"userId = {userId}");
                    dr[0].Delete();
                }
            }

            //update
            SqlCommandBuilder builder = new SqlCommandBuilder(adapter);
            adapter.UpdateCommand = builder.GetDeleteCommand();
            adapter.Update(ds, "tblUsers");

            // הדפסת הטבלה המעודכנת //
            string table = BuildUsersTable(ds.Tables["tblUsers"]);
            tableDiv.InnerHtml = table;
        }
        public void Edit(object sender, EventArgs e)
        {
            for (int i = 1; i < Request.Form.Count; i++)
            {
                if (Request.Form.AllKeys[i].Contains("chk"))
                {
                    Session["userToUpdate"] = int.Parse(Request.Form.AllKeys[i].Remove(0, 3));
                    Response.Redirect("/EditUser.aspx");
                }
            }
            message.InnerHtml = "No user was Selected";
        }
    
    }
}