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
        public Course getCourseByID(int courseID)
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
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setCourseName((string)dr["courseName"]);
                    toReturn.setPrice((double)(dr["price"]));
                    toReturn.setInternalOrExternal((string)dr["internalOrExternal"]);
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["courseProvider"]);
                    }
                    toReturn.setStartDate(dr.GetDateTime(5));
                    toReturn.setEndDate(dr.GetDateTime(6));
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setOverseas((string)dr["overseas"]);
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
                    c = new Course();
                    c.setCourseID((int)dr["courseID"]);
                    c.setCourseName((string)dr["courseName"]);
                    c.setPrice((double)(dr["price"]));
                    c.setInternalOrExternal((string)dr["internalOrExternal"]);
                    if (!dr.IsDBNull(4))
                    {
                        c.setCourseProvider((string)dr["courseProvider"]);
                    }
                    c.setStartDate(dr.GetDateTime(5));
                    c.setEndDate(dr.GetDateTime(6));
                    c.setStatus((string)dr["status"]);
                    c.setOverseas((string)dr["overseas"]);

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