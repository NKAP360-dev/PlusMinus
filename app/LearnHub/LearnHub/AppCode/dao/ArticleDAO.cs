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
    public class ArticleDAO
    {
        public void updateArticle(Article a) // Update.
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
                    "Update [Articles] SET article_name=@name, article_body=@body WHERE article_id = @id";
                comm.Parameters.AddWithValue("@name", a.article_name);
                comm.Parameters.AddWithValue("@body", a.article_body);
                comm.Parameters.AddWithValue("@id", a.article_id);
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
        public Article getArticleById(int id)
        {
            SqlConnection conn = new SqlConnection();
            Article a = new Article();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Articles] where article_id = @aid";
                comm.Parameters.AddWithValue("@aid", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    //Article a = new Article();
                    a.article_id = ((int)dr["article_id"]);
                    a.article_name = ((string)dr["article_name"]);
                    a.article_body = ((string)dr["article_body"]);
                    a.upload_datetime = ((DateTime)dr["timestamp"]);
                    string userid = (string)dr["user_upload"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string)dr["status"]);
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
        public void deactivateArticle(int articleID) // Update.
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
                    "Update [Articles] SET status='Inactive' WHERE article_id=@articleID";
                comm.Parameters.AddWithValue("@articleID", articleID);
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
        public ArrayList getArticles()
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
                comm.CommandText = "select * from [Articles] where status = 'Active' order by article_id desc";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Article a = new Article();
                    a.article_id = ((int)dr["article_id"]);
                    a.article_name = ((string)dr["article_name"]);
                    a.article_body = ((string)dr["article_body"]);
                    a.upload_datetime = ((DateTime)dr["timestamp"]);
                    string userid = (string)dr["user_upload"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string)dr["status"]);
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
        public int createArticle(Article a) // Insert.
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
                comm.CommandText = "insert into [Articles] (article_name, article_body, timestamp, user_upload, status) OUTPUT INSERTED.article_id VALUES (@name, @body, convert(datetime,@stamp,103), @user, @status)";
                comm.Parameters.AddWithValue("@name", a.article_name);
                comm.Parameters.AddWithValue("@body", a.article_body);
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