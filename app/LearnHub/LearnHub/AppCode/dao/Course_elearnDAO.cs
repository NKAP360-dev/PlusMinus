using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Collections;

namespace LearnHub.AppCode.dao
{
    public class Course_elearnDAO
    {

        public Course_elearn create_elearnCourse(Course_elearn course)
        {
            SqlConnection conn = new SqlConnection();
            Course_elearn toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Elearn_course] " +
                    "(elearn_courseName, elearn_courseProvider, entry_date, start_date, expiry_date, status, description, category) " +
                    "values (@cName, @provider, @entry, @time, @expiry, @status, @desc, @category)";
                comm.Parameters.AddWithValue("@cName", course.getCourseName());
                if (course.getCourseProvider() != null)
                {
                    comm.Parameters.AddWithValue("@provider", course.getCourseProvider());
                }
                else
                {
                    comm.Parameters.AddWithValue("@provider", DBNull.Value);
                }

                comm.Parameters.AddWithValue("@entry", course.getEntryDate().ToString());
                if (course.getStartDate() == null)
                {
                    comm.Parameters.AddWithValue("@time", DBNull.Value);
                }
                else
                {
                    comm.Parameters.AddWithValue("@time", course.getStartDate().ToString());
                }
                if (course.getExpiryDate() == null)
                {
                    comm.Parameters.AddWithValue("@expiry", DBNull.Value);
                }
                else
                {
                    comm.Parameters.AddWithValue("@expiry", course.getExpiryDate().ToString());
                }
                comm.Parameters.AddWithValue("@status", course.getStatus());
                comm.Parameters.AddWithValue("@desc", course.getDescription());
                comm.Parameters.AddWithValue("@category", course.getCategory());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = course;
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

        public ArrayList view_courses(String type)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn_list = new ArrayList();
            Course_elearn toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * " +
                    "from [Elearn_course] where status = 'Open' and category = @cat and start_date<=getDate()";
                comm.Parameters.AddWithValue("@cat", type);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course_elearn();
                    int cid = (int)dr["elearn_courseID"]; //1
                    toReturn.setCourseID(cid);
                    toReturn.setCourseName((string)dr["elearn_courseName"]); //2
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["elearn_courseProvider"]);
                    };
                    toReturn.setStartDate((DateTime)dr["start_date"]);//3
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setExpiryDate((DateTime)dr["expiry_date"]);
                    }
                    toReturn.setStatus((string)dr["status"]);//4
                    //get the prereq
                    toReturn.setDescription((string)dr["description"]);//6
                    ArrayList list = getPrereqOfCourse(cid);//5
                    if (list != null)
                    {
                        toReturn.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    toReturn.setCategory((string)dr["category"]);//7
                    toReturn_list.Add(toReturn); //add to arraylist to return of all courses related to given category
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
            return toReturn_list;
        }

        private ArrayList getPrereqOfCourse(int course_id)
        {
            ArrayList toReturn_list = new ArrayList();
            SqlConnection conn = new SqlConnection();
            Course_elearn toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Elearn_course ce inner join " +
                    "(select prereq_courseID from Elearn_prerequisites where elearn_courseID = @check) " +
                    "as temp on ce.elearn_courseID = temp.prereq_courseID;"; //get data of all courses that are prereqs
                comm.Parameters.AddWithValue("@check", course_id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course_elearn();
                    toReturn.setCourseID((int)dr["elearn_courseID"]);
                    toReturn.setCourseName((string)dr["elearn_courseName"]);
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["elearn_courseProvider"]);
                    };
                    toReturn.setStartDate((DateTime)dr["start_date"]);
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setExpiryDate((DateTime)dr["expiry_date"]);
                    }
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setDescription((string)dr["description"]);
                    toReturn.setCategory((string)dr["category"]);
                    toReturn_list.Add(toReturn); //parse as course_elearn object to store and return in arraylist
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
            return toReturn_list;
        }
        public Course_elearn get_course_by_id(int id)
        {
            SqlConnection conn = new SqlConnection();
            Course_elearn toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Elearn_course] where elearn_courseID=@id";
                comm.Parameters.AddWithValue("@id", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course_elearn();
                    int cid = (int)dr["elearn_courseID"]; //1
                    toReturn.setCourseID(cid);
                    toReturn.setCourseName((string)dr["elearn_courseName"]); //2
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["elearn_courseProvider"]);
                    };
                    toReturn.setStartDate((DateTime)dr["start_date"]);//3
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setExpiryDate((DateTime)dr["expiry_date"]);
                    }
                    toReturn.setStatus((string)dr["status"]);//4
                    //get the prereq
                    toReturn.setDescription((string)dr["description"]);//6
                    ArrayList list = getPrereqOfCourse(cid);//5
                    if (list != null)
                    {
                        toReturn.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    toReturn.setCategory((string)dr["category"]);//7
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

        public Course_elearn get_course_by_name(Course_elearn getThis)
        {
            SqlConnection conn = new SqlConnection();
            Course_elearn toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Elearn_course where elearn_courseName =@name";
                comm.Parameters.AddWithValue("@name", getThis.getCourseName());
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course_elearn();
                    int cid = (int)dr["elearn_courseID"]; //1
                    toReturn.setCourseID(cid);
                    toReturn.setCourseName((string)dr["elearn_courseName"]); //2
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["elearn_courseProvider"]);
                    };
                    toReturn.setStartDate((DateTime)dr["start_date"]);//3
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setExpiryDate((DateTime)dr["expiry_date"]);
                    }
                    toReturn.setStatus((string)dr["status"]);//4
                    //get the prereq
                    toReturn.setDescription((string)dr["description"]);//6
                    ArrayList list = getPrereqOfCourse(cid);//5
                    if (list != null)
                    {
                        toReturn.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    toReturn.setCategory((string)dr["category"]);//7
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