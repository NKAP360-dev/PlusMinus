using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class CourseDAO
    {
        public Course getCourseByID(string courseID)
        {
            SqlConnection conn = new SqlConnection();
            Course toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Course] where courseID=@courseID";
                comm.Parameters.AddWithValue("@courseID", courseID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course();
                    toReturn.setCourseID((string)dr["courseID"]);
                    toReturn.setCourseName((string)dr["courseName"]);
                    toReturn.setPrice(Convert.ToSingle(dr["price"]));
                    toReturn.setVendor((string)dr["vendor"]);
                    toReturn.setVendorDetails((string)dr["details"]);
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

        public List<Course> getAllCourses()
        {
            List<Course> toReturn = new List<Course>();
            SqlConnection conn = new SqlConnection();
            Course c = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Course]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    c = new Course();
                    c.setCourseID((string)dr["courseID"]);
                    c.setCourseName((string)dr["courseName"]);
                    c.setPrice(Convert.ToSingle(dr["price"]));
                    c.setVendor((string)dr["vendor"]);
                    c.setVendorDetails((string)dr["details"]);

                    toReturn.Add(c);
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