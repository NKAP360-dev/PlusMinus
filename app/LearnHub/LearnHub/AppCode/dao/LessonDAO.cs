using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class LessonDAO
    {
        public List<Lesson> getAllLessonsByCourseID(int courseID)
        {
            SqlConnection conn = new SqlConnection();
            List<Lesson> toReturn = new List<Lesson>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Lesson] where courseID=@courseID";
                comm.Parameters.AddWithValue("@courseID", courseID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Lesson l = new Lesson();
                    l.setLessonID((int)dr["lessonID"]);
                    l.setCourseID((int)dr["courseID"]);
                    l.setStartTime((TimeSpan)dr["lesson_start_timing"]);
                    l.setEndTime((TimeSpan)dr["lesson_end_timing"]);
                    l.setStartDate(dr.GetDateTime(4));
                    l.setEndDate(dr.GetDateTime(5));
                    l.setInstructor((string)dr["instructor"]);
                    l.setVenue((string)dr["venue"]);

                    toReturn.Add(l);
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
        public Lesson getLessonByID(int lessonID)
        {
            SqlConnection conn = new SqlConnection();
            Lesson toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Lesson] where lessonID=@lessonID";
                comm.Parameters.AddWithValue("@lessonID", lessonID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Lesson();
                    toReturn.setLessonID((int)dr["lessonID"]);
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setStartTime((TimeSpan)dr["lesson_start_timing"]);
                    toReturn.setEndTime((TimeSpan)dr["lesson_end_timing"]);
                    toReturn.setStartDate(dr.GetDateTime(4));
                    toReturn.setEndDate(dr.GetDateTime(5));
                    toReturn.setInstructor((string)dr["instructor"]);
                    toReturn.setVenue((string)dr["venue"]);
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