using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using LearnHub.AppCode.entity;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class Course_elearnCategoryDAO
    {
        public List<CourseCategory> getAllCategory()
        {
            SqlConnection conn = new SqlConnection();
            List<CourseCategory> toReturn = new List<CourseCategory>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Elearn_courseCategory]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    CourseCategory cc = new CourseCategory();
                    cc.categoryID = (int)dr["categoryID"];
                    cc.category = (string)dr["category"];
                    cc.status = (string)dr["status"];
                    toReturn.Add(cc);
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

        public List<CourseCategory> getAllActiveCategory()
        {
            SqlConnection conn = new SqlConnection();
            List<CourseCategory> toReturn = new List<CourseCategory>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Elearn_courseCategory] where status=@status";
                comm.Parameters.AddWithValue("@status", "active");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    CourseCategory cc = new CourseCategory();
                    cc.categoryID = (int)dr["categoryID"];
                    cc.category = (string)dr["category"];
                    cc.status = (string)dr["status"];
                    toReturn.Add(cc);
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

        public CourseCategory getCategoryByID(int categoryID)
        {
            SqlConnection conn = new SqlConnection();
            CourseCategory toReturn = new CourseCategory();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Elearn_courseCategory] where categoryID=@categoryID";
                comm.Parameters.AddWithValue("@categoryID", categoryID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.categoryID = (int)dr["categoryID"];
                    toReturn.category = (string)dr["category"];
                    toReturn.status = (string)dr["status"];
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
        public void updateCategory(string category, int categoryID) // Update.
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
                    "Update [Elearn_courseCategory] SET category=@category WHERE categoryID=@categoryID";
                comm.Parameters.AddWithValue("@categoryID", categoryID);
                comm.Parameters.AddWithValue("@category", category);
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
        public int createCategory(CourseCategory cc) // Insert.
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
                comm.CommandText = "Insert into [Elearn_courseCategory] (category, status) OUTPUT INSERTED.categoryID VALUES (@category, @status)";
                comm.Parameters.AddWithValue("@category", cc.category);
                comm.Parameters.AddWithValue("@status", cc.status);
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
        public void deactivateCategory(int categoryID) // Update.
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
                    "Update [Elearn_courseCategory] SET status=@status WHERE categoryID=@categoryID";
                comm.Parameters.AddWithValue("@categoryID", categoryID);
                comm.Parameters.AddWithValue("@status", "inactive");
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
        public void activateCategory(int categoryID) // Update.
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
                    "Update [Elearn_courseCategory] SET status=@status WHERE categoryID=@categoryID";
                comm.Parameters.AddWithValue("@categoryID", categoryID);
                comm.Parameters.AddWithValue("@status", "active");
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
    }
}