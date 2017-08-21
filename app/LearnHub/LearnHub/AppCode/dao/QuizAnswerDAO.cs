using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class QuizAnswerDAO
    {
        public QuizAnswer getQuizAnswerByID(int quizAnswerID)
        {
            SqlConnection conn = new SqlConnection();
            QuizAnswer toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizAnswer] where quizAnswerID=@quizAnswerID";
                comm.Parameters.AddWithValue("@quizAnswerID", quizAnswerID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new QuizAnswer();
                    toReturn.setAnswer((string)dr["answer"]);
                    QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                    toReturn.setQuizQuestion(qqDAO.getQuizQuestionByID((int)dr["quizQuestionID"]));
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
        public int createQuizAnswer(QuizAnswer qa) // Insert.
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
                comm.CommandText = "Insert into [QuizAnswer] (quizQuestionID, answer) OUTPUT INSERTED.quizAnswerID VALUES (@quizQuestionID, @answer)";
                comm.Parameters.AddWithValue("@quizQuestionID", qa.getQuizQuestion().getQuizQuestionID());
                comm.Parameters.AddWithValue("@answer", qa.getAnswer());
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