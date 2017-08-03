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
    }
}