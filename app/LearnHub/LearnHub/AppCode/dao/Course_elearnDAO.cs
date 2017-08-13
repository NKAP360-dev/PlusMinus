﻿using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Collections;
using System.IO;

namespace LearnHub.AppCode.dao
{
    public class Course_elearnDAO
    {
        public ArrayList get_uploaded_content_by_id(Course_elearn course)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn_list = new ArrayList();
            Upload toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select upload_date, upload_title, upload_desc, server_path from [Elearn_courseContent] where elearn_courseID=@id";
                comm.Parameters.AddWithValue("@id", course.getCourseID());
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Upload();
                 
                    toReturn.setDate((DateTime)dr["upload_date"]);//3
                    
                    toReturn.setTitle((string)dr["upload_title"]);//4

                    toReturn.setDesc((string)dr["upload_desc"]);//6

                    if (dr["server_path"]!=DBNull.Value)
                    {
                        toReturn.setServerPath((string)dr["server_path"]);
                    }

                    toReturn_list.Add(toReturn);
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

        public Upload upload_entry(Upload upload)
        {
            SqlConnection conn = new SqlConnection();
            Upload toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Elearn_courseContent] "
                                    + "(elearn_courseID, upload_date, upload_title, upload_desc, server_path)"
                                    + "values(@id, Convert(datetime, @date, 103), @title, @desc, @server_path)";
                comm.Parameters.AddWithValue("@id", upload.getCourse_elearn().getCourseID());
                comm.Parameters.AddWithValue("@date", upload.getDate());
                comm.Parameters.AddWithValue("@title", upload.getTitle());
                comm.Parameters.AddWithValue("@desc", upload.getDesc());
                comm.Parameters.AddWithValue("@server_path", upload.getServerPath());
                //comm.Parameters.AddWithValue("@content", course.getCourseID());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = upload;
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
                    "(elearn_courseName, elearn_courseProvider, entry_date, start_date, expiry_date, status, description, categoryID, courseCreator, hoursAwarded, targetAudience) " +
                    "values (@cName, @provider, Convert(datetime, @entry, 103), convert(datetime,@time,103), Convert(datetime,@expiry,103), @status, @desc, @category, @courseCreator, @hoursAwarded, @targetAudience)";
                comm.Parameters.AddWithValue("@cName", course.getCourseName());
                if (course.getCourseProvider() != null)
                {
                    comm.Parameters.AddWithValue("@provider", course.getCourseProvider());
                }
                else
                {
                    comm.Parameters.AddWithValue("@provider", DBNull.Value);
                }

                comm.Parameters.AddWithValue("@entry", course.getEntryDate());
                if (course.getStartDate() == null)
                {
                    comm.Parameters.AddWithValue("@time", DBNull.Value);
                }
                else
                {
                    comm.Parameters.AddWithValue("@time", course.getStartDate());
                }
                if (course.getExpiryDate() == null)
                {
                    comm.Parameters.AddWithValue("@expiry", DBNull.Value);
                }
                else
                {
                    comm.Parameters.AddWithValue("@expiry", course.getExpiryDate());
                }
                comm.Parameters.AddWithValue("@status", course.getStatus());
                comm.Parameters.AddWithValue("@desc", course.getDescription());
                comm.Parameters.AddWithValue("@category", course.getCategoryID());
                comm.Parameters.AddWithValue("@courseCreator", course.getCourseCreator().getUserID());
                comm.Parameters.AddWithValue("@hoursAwarded", course.getHoursAwarded());
                comm.Parameters.AddWithValue("@targetAudience", course.getTargetAudience());
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

        public ArrayList view_courses(int categoryID)
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
                    "from [Elearn_course] where status = 'Open' and categoryID = @cat and start_date<=getDate()";
                comm.Parameters.AddWithValue("@cat", categoryID);
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
                    toReturn.setCategoryID((int)dr["categoryID"]);//7
                    toReturn.setHoursAwarded((int)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        toReturn.setTargetAudience((string)dr["targetAudience"]);
                    }
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

        public ArrayList getPrereqOfCourse(int course_id)
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
                    toReturn.setCategoryID((int)dr["categoryID"]);
                    toReturn.setHoursAwarded((int)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        toReturn.setTargetAudience((string)dr["targetAudience"]);
                    }
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
            UserDAO userDAO = new UserDAO();
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
                    toReturn.setEntryDate((DateTime)dr["entry_date"]);
                    ArrayList list = getPrereqOfCourse(cid);//5
                    if (list != null)
                    {
                        toReturn.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    toReturn.setCategoryID((int)dr["categoryID"]);//7
                    toReturn.setCourseCreator(userDAO.getUserByID((string)dr["courseCreator"]));
                    toReturn.setHoursAwarded((int)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        toReturn.setTargetAudience((string)dr["targetAudience"]);
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
                    toReturn.setCategoryID((int)dr["categoryID"]);//7
                    toReturn.setHoursAwarded((int)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        toReturn.setTargetAudience((string)dr["targetAudience"]);
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
        public void updateCourse(int courseID, int categoryID, string name, string description, int hours, DateTime start, DateTime expiry) // Update.
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
                    "Update [Elearn_course] SET elearn_courseName=@name, description=@description, categoryID=@category, start_date=@start, expiry_date=@expiry, hoursAwarded=@hours WHERE elearn_courseID=@courseID";
                comm.Parameters.AddWithValue("@name", name);
                comm.Parameters.AddWithValue("@description", description);
                comm.Parameters.AddWithValue("@category", categoryID);
                comm.Parameters.AddWithValue("@start", start);
                comm.Parameters.AddWithValue("@expiry", expiry);
                comm.Parameters.AddWithValue("@hours", hours);
                comm.Parameters.AddWithValue("@courseID", courseID);
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

        public List<Course_elearn> viewAvailablePrerequisiteCourses()
        {
            SqlConnection conn = new SqlConnection();
            List<Course_elearn> toReturn_list = new List<Course_elearn>();
            Course_elearn toReturn;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * " +
                    "from [Elearn_course] where status = 'Open' and start_date<=getDate()";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course_elearn();
                    toReturn.setCourseID((int)dr["elearn_courseID"]); //1
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
                    ArrayList list = getPrereqOfCourse((int)dr["elearn_courseID"]);//5
                    if (list != null)
                    {
                        toReturn.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    toReturn.setCategoryID((int)dr["categoryID"]);//7
                    toReturn.setHoursAwarded((int)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        toReturn.setTargetAudience((string)dr["targetAudience"]);
                    }
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
        public string getCourseCategoryByID(int categoryID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select category from [Elearn_courseCategory] where categoryID=@id";
                comm.Parameters.AddWithValue("@id", categoryID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["category"];
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
        public Boolean insertPrerequisite(int courseID, int prereqID)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Elearn_prerequisites] "
                                    + "(elearn_courseID, prereq_courseID)"
                                    + "values(@courseID, @prereqID)";
                comm.Parameters.AddWithValue("@courseID", courseID);
                comm.Parameters.AddWithValue("@prereqID", prereqID);
                int rowsAffected = comm.ExecuteNonQuery();
                toReturn = true;
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

        public void updateCourseTargetAudience(int courseID, string targetAudience) // Update.
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
                    "Update [Elearn_course] SET targetAudience=@targetAudience WHERE elearn_courseID=@courseID";
                comm.Parameters.AddWithValue("@targetAudience", targetAudience);
                comm.Parameters.AddWithValue("@courseID", courseID);
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
        public List<int> getAllCourseLinkedToPrerequisite(int prereq_courseID)
        {
            SqlConnection conn = new SqlConnection();
            List<int> toReturn = new List<int>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select elearn_courseID from [Elearn_prerequisites] where prereq_courseID =@prereq_courseID";
                comm.Parameters.AddWithValue("@prereq_courseID", prereq_courseID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((int)dr["elearn_courseID"]);
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