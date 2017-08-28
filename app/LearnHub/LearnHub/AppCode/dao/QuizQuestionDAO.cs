using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class QuizQuestionDAO
    {
        public QuizQuestion getQuizQuestionByID(int quizQuestionID)
        {
            SqlConnection conn = new SqlConnection();
            QuizQuestion toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizQuestion] where quizQuestionID=@quizQuestionID";
                comm.Parameters.AddWithValue("@quizQuestionID", quizQuestionID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new QuizQuestion();
                    toReturn.setQuizQuestionID((int)dr["quizQuestionID"]);
                    toReturn.setQuestion((string)dr["question"]);
                    QuizDAO qDAO = new QuizDAO();
                    toReturn.setQuiz(qDAO.getQuizByID((int)dr["quizID"]));
                    QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                    toReturn.setQuizAnswer(qaDAO.getQuizAnswerByID((int)dr["correctAnswerID"]));
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
        public int createQuizQuestion(QuizQuestion qq) // Insert.
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
                comm.CommandText = "Insert into [QuizQuestion] (quizID, question, correctAnswerID) OUTPUT INSERTED.quizQuestionID VALUES (@quizID, @question, @correctAnswerID)";
                comm.Parameters.AddWithValue("@quizID", qq.getQuiz().getQuizID());
                comm.Parameters.AddWithValue("@question", qq.getQuestion());
                if (qq.getQuizAnswer() != null)
                {
                    comm.Parameters.AddWithValue("@correctAnswerID", qq.getQuizAnswer().getQuizAnswerID());
                }
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
        public void updateCorrectAnswerID(int quizQuestionID, int answerID) // Update.
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
                    "Update [QuizQuestion] SET correctAnswerID=@correctAnswerID WHERE quizQuestionID=@quizQuestionID";
                comm.Parameters.AddWithValue("@correctAnswerID", answerID);
                comm.Parameters.AddWithValue("@quizQuestionID", quizQuestionID);
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
        public List<QuizQuestion> getAllQuizQuestionByQuizID(int quizID)
        {
            SqlConnection conn = new SqlConnection();
            List<QuizQuestion> toReturn = new List<QuizQuestion>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizQuestion] where quizID=@quizID";
                comm.Parameters.AddWithValue("@quizID", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    QuizQuestion qq = new QuizQuestion();
                    qq.setQuizQuestionID((int)dr["quizQuestionID"]);
                    qq.setQuestion((string)dr["question"]);
                    QuizDAO qDAO = new QuizDAO();
                    qq.setQuiz(qDAO.getQuizByID((int)dr["quizID"]));
                    QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                    qq.setQuizAnswer(qaDAO.getCorrectQuizAnswerByID((int)dr["correctAnswerID"]));
                    toReturn.Add(qq);
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