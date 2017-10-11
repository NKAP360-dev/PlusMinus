using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using LearnHub.AppCode.dao;
using System.Collections;


namespace LearnHub.AppCode.dao
{
    public class LinkDAO
    {
        public void updateLink(Link a) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [Links] SET link_path=@name, description=@body WHERE link_id = @id";
                comm.Parameters.AddWithValue("@name", a.link_path);
                comm.Parameters.AddWithValue("@body", a.description);
                comm.Parameters.AddWithValue("@id", a.link_id);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public Link getLinksById(int id)
        {
            SqlConnection conn = new SqlConnection();
            Link a = new Link();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Links] where link_id = @id";
                comm.Parameters.AddWithValue("@id", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    //Article a = new Article();
                    a.link_path = ((string)dr["link_path"]);
                    a.description = ((string)dr["description"]);
                    //a.upload_datetime = ((string)dr["upload_datetime"]);
                    a.upload_datetime = ((DateTime)dr["upload_datetime"]);
                    string userid = (string)dr["upload_user"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string)dr["status"]);
                    a.link_id = ((int)dr["link_id"]);
                    //toReturn.Add(a);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return a;
        }
        public void deactivateArticle(int linkID) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [Links] SET status='Inactive' WHERE link_id=@link_id";
                comm.Parameters.AddWithValue("@link_id", linkID);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public ArrayList getLinks()
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Links] where status = 'Active' order by link_id desc";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Link a = new Link();
                    a.link_path = ((string)dr["link_path"]);
                    a.description = ((string)dr["description"]);
                    a.upload_datetime = ((DateTime)dr["upload_datetime"]);
                    string userid = (string)dr["upload_user"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string)dr["status"]);
                    a.link_id = ((int)dr["link_id"]);
                    toReturn.Add(a);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public int createLink(Link a) // Insert.
        {
            SqlConnection conn = null;
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Links] "
                                    + "(link_path, description, upload_datetime, upload_user, status) OUTPUT INSERTED.link_id"
                                    + "values(@path, @desc, convert(datetime,@stamp,103), @user, @status)";
                comm.Parameters.AddWithValue("@path", a.link_path);
                comm.Parameters.AddWithValue("@desc", a.description);
                comm.Parameters.AddWithValue("@stamp", a.upload_datetime);
                comm.Parameters.AddWithValue("@user", a.user.getUserID());
                comm.Parameters.AddWithValue("@status", a.status);
                toReturn = (Int32)comm.ExecuteScalar();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
    }
}