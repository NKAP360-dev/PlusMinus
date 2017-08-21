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
        public QuizResultHistory getQuizResultHistoryByID(int quizResultHistoryID)
        {
            SqlConnection conn = new SqlConnection();
            QuizResultHistory toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResultHistory] where quizResultHistoryID=@quizResultHistoryID";
                comm.Parameters.AddWithValue("@quizResultHistoryID", quizResultHistoryID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new QuizResultHistory();
                    toReturn.setQuizResultHistoryID((int)dr["quizResultHistoryID"]);
                    QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                    QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                    toReturn.setQuestion(qqDAO.getQuizQuestionByID((int)dr["quizQuestionID"]));
                    toReturn.setAnswer(qaDAO.getQuizAnswerByID((int)dr["quizAnswerID"]));
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
        public int createQuizResultHistory(QuizResultHistory qrh) // Insert.
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
                comm.CommandText = "Insert into [QuizResultHistory] (quizQuestionID, quizAnswerID) OUTPUT INSERTED.quizResultHistoryID VALUES (@quizQuestionID, @quizAnswerID)";
                comm.Parameters.AddWithValue("@quizQuestionID", qrh.getQuestion().getQuizQuestionID());
                comm.Parameters.AddWithValue("@quizAnswerID", qrh.getAnswer().getQuizAnswerID());
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