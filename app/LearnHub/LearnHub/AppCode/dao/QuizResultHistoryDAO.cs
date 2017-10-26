using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class QuizResultHistoryDAO
    {
        public List<QuizResultHistory> getAllQuizResultHistoryByQuizIDandAttempt(int attempt, int quizID)
        {
            SqlConnection conn = new SqlConnection();
            List<QuizResultHistory> toReturn = new List<QuizResultHistory>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResultHistory] where attempt=@attempt and quizID=@quizID";
                comm.Parameters.AddWithValue("@attempt", attempt);
                comm.Parameters.AddWithValue("quizID", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    QuizResultHistory qrh = new QuizResultHistory();
                    qrh.setUserID((string)dr["userID"]);
                    QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                    QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                    qrh.setQuestion(qqDAO.getQuizQuestionByID((int)dr["quizQuestionID"]));
                    qrh.setAnswer(qaDAO.getQuizAnswerByID((int)dr["quizAnswerID"]));
                    qrh.setAttempt((int)dr["attempt"]);
                    qrh.setQuizID((int)dr["quizID"]);
                    toReturn.Add(qrh);
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
        public Boolean createQuizResultHistory(QuizResultHistory qrh) // Insert.
        {
            SqlConnection conn = null;
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [QuizResultHistory] (userID, quizQuestionID, quizAnswerID, attempt, quizID) VALUES (@userID, @quizQuestionID, @quizAnswerID, @attempt, @quizID)";
                comm.Parameters.AddWithValue("@userID", qrh.getUserID());
                comm.Parameters.AddWithValue("@quizQuestionID", qrh.getQuestion().getQuizQuestionID());
                comm.Parameters.AddWithValue("@quizAnswerID", qrh.getAnswer().getQuizAnswerID());
                comm.Parameters.AddWithValue("@attempt", qrh.getAttempt());
                comm.Parameters.AddWithValue("@quizID", qrh.getQuizID());
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
        public int getAttemptForQuiz(int quizQuestionID)
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select attempt from [QuizResultHistory] where quizQuestionID=@quizQuestionID";
                comm.Parameters.AddWithValue("@quizQuestionID", quizQuestionID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["attempt"];
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
        public int getAllQuizAnswerIDByQuizIDandAttemptandQuestionIDandUserID(int attempt, int quizID, int quizQuestionID, string userID)
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select quizAnswerID from [QuizResultHistory] where attempt=@attempt and quizID=@quizID and quizQuestionID=@quizQuestionID";
                comm.Parameters.AddWithValue("@attempt", attempt);
                comm.Parameters.AddWithValue("quizID", quizID);
                comm.Parameters.AddWithValue("quizQuestionID", quizQuestionID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["quizAnswerID"];
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

        public List<QuizResultHistory> getAll()
        {
            SqlConnection conn = new SqlConnection();
            List<QuizResultHistory> toReturn = new List<QuizResultHistory>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResultHistory]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    QuizResultHistory qrh = new QuizResultHistory();
                    qrh.setUserID((string)dr["userID"]);
                    QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                    QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                    qrh.setQuestion(qqDAO.getQuizQuestionByID((int)dr["quizQuestionID"]));
                    qrh.setAnswer(qaDAO.getQuizAnswerByID((int)dr["quizAnswerID"]));
                    qrh.setAttempt((int)dr["attempt"]);
                    qrh.setQuizID((int)dr["quizID"]);
                    toReturn.Add(qrh);
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