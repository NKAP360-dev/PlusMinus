using LearnHub.AppCode.entity;
using System;
using System.Collections;
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
        public ArrayList getPrereqOfQuiz(int quizID)
        {
            ArrayList toReturn_list = new ArrayList();
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
                comm.CommandText = "select * from Quiz q inner join " +
                    "(select prereq_quizID from QuizPrerequisite where quizID = @check) " +
                    "as temp on q.quizID = temp.prereq_quizID;"; //get data of all courses that are prereqs
                comm.Parameters.AddWithValue("@check", quizID);
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
        public List<int> getAllQuizLinkedToPrerequisite(int prereq_quizID)
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
                comm.CommandText = "select quizID from [QuizPrerequisite] where prereq_quizID =@prereq_quizID";
                comm.Parameters.AddWithValue("@prereq_quizID", prereq_quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((int)dr["quizID"]);
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
        public Boolean insertPrerequisite(int quizID, int prereqID)
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
                comm.CommandText = "insert into [QuizPrerequisite] "
                                    + "(quizID, prereq_quizID)"
                                    + "values(@quizID, @prereqID)";
                comm.Parameters.AddWithValue("@quizID", quizID);
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
    }
}