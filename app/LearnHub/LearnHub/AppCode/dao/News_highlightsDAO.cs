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
    public class News_highlightsDAO
    {
        public void deactivateNewsHighlight(int id) // Update.
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
                    "Update [News_highlights] SET status='Inactive' WHERE highlight_id=@articleID";
                comm.Parameters.AddWithValue("@articleID", id);
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
        public Boolean updateHighlight(News_highlights a) // Update.
        {
            SqlConnection conn = new SqlConnection();
            Boolean rowsAffected = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [News_highlights] SET title=@title, body=@body, news_text=@text, img_path=@img_path, type=@type WHERE highlight_id = @id";
                comm.Parameters.AddWithValue("@title", a.title);
                comm.Parameters.AddWithValue("@body", a.body);
                comm.Parameters.AddWithValue("@text", a.news_text);
                comm.Parameters.AddWithValue("@img_path", a.img_path);
                comm.Parameters.AddWithValue("@type", a.type);
                comm.Parameters.AddWithValue("@id", a.highlight_id);
                rowsAffected = true;
                comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return rowsAffected;
        }
        public Boolean updateHighlightNoImg(News_highlights a) // Update.
        {
            SqlConnection conn = new SqlConnection();
            Boolean rowsAffected = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [News_highlights] SET title=@title, body=@body, news_text=@text, type=@type WHERE highlight_id = @id";
                comm.Parameters.AddWithValue("@title", a.title);
                comm.Parameters.AddWithValue("@body", a.body);
                comm.Parameters.AddWithValue("@text", a.news_text);
                //comm.Parameters.AddWithValue("@img_path", a.img_path);
                comm.Parameters.AddWithValue("@type", a.type);
                comm.Parameters.AddWithValue("@id", a.highlight_id);
                rowsAffected = true;
                comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return rowsAffected;
        }
        public News_highlights getHighlightById(int id)
        {
            SqlConnection conn = new SqlConnection();
            News_highlights a = new News_highlights();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [News_highlights] where highlight_id = @aid";
                comm.Parameters.AddWithValue("@aid", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    //News_highlights a = new News_highlights();
                    string userid = (string)dr["user_id"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.entry_time = ((DateTime)dr["date_posted"]);
                    a.title = ((string)dr["title"]);
                    a.body = ((string)dr["body"]);
                    a.news_text = ((string)dr["news_text"]);
                    a.highlight_id = ((int)dr["highlight_id"]);
                    string status = (string)dr["status"];
                    a.img_path = ((string)dr["img_path"]);
                    a.type = ((string)dr["type"]);
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
        public int getHighlightIdLatest()
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select max(highlight_id) as temp from News_highlights";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = ((int)dr["temp"]);
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
        public ArrayList getNewsHighlights()
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
                comm.CommandText = "select * from [News_highlights] where status = 'Active' order by date_posted desc";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    News_highlights a = new News_highlights();
                    string userid = (string)dr["user_id"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.entry_time = ((DateTime)dr["date_posted"]);
                    a.title = ((string)dr["title"]);
                    a.body = ((string)dr["body"]);
                    a.news_text = ((string)dr["news_text"]);
                    a.highlight_id = ((int)dr["highlight_id"]);
                    string status = (string)dr["status"];
                    a.img_path = ((string)dr["img_path"]);
                    a.type = ((string)dr["type"]);
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
        public int createNewsHighlight(News_highlights a) // Insert.
        {
            SqlConnection conn = null;
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [News_highlights] (date_posted, title, body, news_text, status, user_id, img_path, type) OUTPUT INSERTED.highlight_id VALUES"
                                    + "(@date, @title, @body, @text, @status, @uid, @img_path, @type)";
                comm.Parameters.AddWithValue("@date", a.entry_time);
                comm.Parameters.AddWithValue("@title", a.title);
                comm.Parameters.AddWithValue("@body", a.body);
                comm.Parameters.AddWithValue("@text", a.news_text);
                comm.Parameters.AddWithValue("@status", a.status);
                comm.Parameters.AddWithValue("@uid", a.user.getUserID());
                comm.Parameters.AddWithValue("@img_path", a.img_path);
                comm.Parameters.AddWithValue("@type", a.type);
                int v = (Int32)comm.ExecuteScalar();
                toReturn = getHighlightIdLatest();
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