using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace project2
{
    public static class Helper
    {
            public const string tblName = "tblUsers";
            public const string conString = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=RecipesDB_AvigailProject2;Integrated Security=True;Connect Timeout=30";

            public static DataSet RetrieveTable(string SQLStr)
            {
                SqlConnection con = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand(SQLStr, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, tblName);
                return ds;
            }

            public static int ExecuteNonQuery(string SQL)
            {
                SqlConnection con = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand(SQL, con);
                con.Open();
                int n = cmd.ExecuteNonQuery();
                con.Close();
                return n;
            }

            public static object GetScalar(string SQL)
            {
                SqlConnection con = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand(SQL, con);
                con.Open();
                object scalar = cmd.ExecuteScalar();
                con.Close();
                return scalar;
            }
    }

}
