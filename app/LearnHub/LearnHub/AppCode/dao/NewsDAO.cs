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
    public class NewsDAO
    {
        public void updateNewsLevel(int id, int levels) // Update.
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
                    "Update [News] SET levels=@levels WHERE banner_id=@id";
                comm.Parameters.AddWithValue("@id", id);
                comm.Parameters.AddWithValue("@levels", levels);
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
        public News getNewsById(int id)
        {
            SqlConnection conn = new SqlConnection();
            News a = new News();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [News] where banner_id = @id";
                comm.Parameters.AddWithValue("@id", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    string userid = (string)dr["userID"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.entry_time = ((DateTime)dr["entry_time_stamp"]);
                    a.banner_name = ((string)dr["banner_name"]);
                    a.banner_link = ((string)dr["banner_link"]);
                    a.banner_id = ((int)dr["banner_id"]);
                    if ((dr["news_text"] != DBNull.Value))
                    {
                        a.news_text = ((string)dr["news_text"]);
                    }
                    else
                    {
                        a.news_text = null;
                    }
                    string status = (string)dr["status"];
                    a.img_path = ((string)dr["img_path"]);
                    a.level = ((int)dr["levels"]);
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
        public void deactivateNews(int news_id) // Update.
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
                    "Update [News] SET status='Inactive' WHERE banner_id=@news_id";
                comm.Parameters.AddWithValue("@news_id", news_id);
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
        public ArrayList getNews()
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
                comm.CommandText = "select * from [News] where status = 'Active' order by levels ";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    News a = new News();
                    string userid = (string)dr["userID"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.entry_time = ((DateTime)dr["entry_time_stamp"]);
                    a.banner_name = ((string)dr["banner_name"]);
                    a.banner_link = ((string)dr["banner_link"]);
                    a.banner_id = ((int)dr["banner_id"]);
                    if((dr["news_text"] != DBNull.Value)){
                        a.news_text = ((string)dr["news_text"]);
                    }
                    else
                    {
                        a.news_text = null;
                    }
                    string status = (string)dr["status"];
                    a.img_path = ((string)dr["img_path"]);
                    a.level = ((int)dr["levels"]);
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
        public int createNewsBanner(News a) // Insert.
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
                comm.CommandText = "insert into [News] (userID, entry_time_stamp, banner_name, banner_link, news_text, status, img_path, levels) OUTPUT INSERTED.banner_id  VALUES"
                                    + "(@id, @date, @name, @link, @news, 'Active', @path, @levels)";
                comm.Parameters.AddWithValue("@id", a.user.getUserID());
                comm.Parameters.AddWithValue("@date", a.entry_time);
                comm.Parameters.AddWithValue("@name", a.banner_name);
                comm.Parameters.AddWithValue("@link", a.banner_link);
                int nextOrderNum = getNextOrderNumber();
                if (a.news_text == null)
                {
                    comm.Parameters.AddWithValue("@news", DBNull.Value);
                }
                else
                {
                    comm.Parameters.AddWithValue("@news", a.news_text);
                }
                comm.Parameters.AddWithValue("@path", a.img_path);
                if (nextOrderNum != -1)
                {
                    nextOrderNum++;
                }
                else
                {
                    nextOrderNum = 0;
                }
                comm.Parameters.AddWithValue("@levels", nextOrderNum);
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
        public int getNextOrderNumber()
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select max(levels) as preference from [News]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    if (!dr.IsDBNull(0))
                    {
                        toReturn = (int)dr["preference"];
                    }
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
    }
}