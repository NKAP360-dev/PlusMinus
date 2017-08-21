using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class QuizDAO
    {
        public Quiz getQuizByID(int quizID)
        {
            SqlConnection conn = new SqlConnection();
            Quiz toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Quiz] where quizID=@quizID";
                comm.Parameters.AddWithValue("@quizID", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Quiz();
                    toReturn.setQuizID((int)dr["quizID"]);
                    toReturn.setTitle((string)dr["title"]);
                    toReturn.setDescription((string)dr["description"]);
                    toReturn.setPassingGrade((int)dr["passingGrade"]);
                    toReturn.setRandomOrder((string)dr["randomOrder"]);
                    toReturn.setStatus((string)dr["status"]);
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    toReturn.setMainCourse(ceDAO.get_course_by_id((int)dr["elearn_courseID"]));
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
        public int createQuiz(Quiz q) // Insert.
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
                comm.CommandText = "Insert into [Quiz] (elearn_courseID, title, description, passingGrade, randomOrder, status) OUTPUT INSERTED.quizID VALUES (@elearn_courseID, @title, @description, @passingGrade, @randomOrder, @status)";
                comm.Parameters.AddWithValue("@elearn_courseID", q.getMainCourse().getCourseID());
                comm.Parameters.AddWithValue("@title", q.getTitle());
                comm.Parameters.AddWithValue("@description", q.getDescription());
                comm.Parameters.AddWithValue("@passingGrade", q.getPassingGrade());
                comm.Parameters.AddWithValue("@randomOrder", q.getRandomOrder());
                comm.Parameters.AddWithValue("@status", q.getStatus());
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