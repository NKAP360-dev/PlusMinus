using LearnHub.AppCode.entity;
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
    public class TestimonialDAO
    {
        public ArrayList get_testimonials_by_course(Course_elearn course)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn_list = new ArrayList();
            Testimonial toReturn = null;
            UserDAO u = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Testimonials where courseID=@id";
                comm.Parameters.AddWithValue("@id", course.getCourseID());
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Testimonial();

                    toReturn.setStaffName((string)dr["staff_name"]);//4

                    toReturn.set_course_elearn(course);//6

                    toReturn.setQuote((string)dr["quote"]);

                    toReturn.setUser(u.getUserByID((String)dr["userID"]));

                    toReturn.setID((int)dr["ID"]);

                    toReturn.setTitle((string)dr["title"]);

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

        public Boolean create_testimonial(Testimonial testimonial)
        {
            SqlConnection conn = new SqlConnection();
            Boolean success = false;
            //DateTime time = ;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Testimonials] values (@name, @quote, @id, @course, @title)";
                comm.Parameters.AddWithValue("@name", testimonial.getStaffName());
                comm.Parameters.AddWithValue("@quote", testimonial.getQuote());
                comm.Parameters.AddWithValue("@id", testimonial.getUser().getUserID());
                //comm.Parameters.AddWithValue("@date", DateTime.Now);
                comm.Parameters.AddWithValue("@course", testimonial.getCourse_elearn().getCourseID());
                comm.Parameters.AddWithValue("@title", testimonial.getTitle());
                //comm.Parameters.AddWithValue("@content", course.getCourseID());
                int rowsAffected = comm.ExecuteNonQuery();
                success = true;

            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return success;
        }

        public Boolean delete_testimonial(int tid, int cid)
        {
            SqlConnection conn = new SqlConnection();
            Boolean success = false;
            //DateTime time = ;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "delete from [Testimonials] where courseID=@cid and ID=@id";
                comm.Parameters.AddWithValue("@cid", cid);
                comm.Parameters.AddWithValue("@id", tid);
                
                int rowsAffected = comm.ExecuteNonQuery();
                success = true;

            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return success;
        }
    }

}