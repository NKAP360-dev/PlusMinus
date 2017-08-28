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
    public class QuizResultDAO
    {
        public QuizResult getQuizResultByID(int quizResultID)
        {
            SqlConnection conn = new SqlConnection();
            QuizResult toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResult] where quizResultID=@quizResultID";
                comm.Parameters.AddWithValue("@quizResultID", quizResultID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new QuizResult();
                    UserDAO userDAO = new UserDAO();
                    QuizDAO quizDAO = new QuizDAO();
                    QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
                    toReturn.setQuizResultID((int)dr["quizResultID"]);
                    toReturn.setUser(userDAO.getUserByID((string)dr["userID"]));
                    toReturn.setQuiz(quizDAO.getQuizByID((int)dr["quizID"]));
                    toReturn.setScore((int)dr["score"]);
                    toReturn.setGrade((string)dr["grade"]);
                    toReturn.setQuizResultHistory(qrhDAO.getQuizResultHistoryByID((int)dr["quizResultHistoryID"]));
                    toReturn.setDateSubmitted(dr.GetDateTime(6));
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
        public int createQuizResult(QuizResult qr) // Insert.
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
                comm.CommandText = "Insert into [QuizResult] (userID, quizID, score, grade, quizResultHistoryID, dateSubmitted) OUTPUT INSERTED.quizResultID VALUES (@userID, @quizID, @score, @grade, @quizResultHistoryID, @dateSubmitted)";
                comm.Parameters.AddWithValue("@userID", qr.getUser().getUserID());
                comm.Parameters.AddWithValue("@quizID", qr.getQuiz().getQuizID());
                comm.Parameters.AddWithValue("@score", qr.getScore());
                comm.Parameters.AddWithValue("@grade", qr.getGrade());
                comm.Parameters.AddWithValue("@quizResultHistoryID", qr.getQuizResultHistory().getQuizResultHistoryID());
                comm.Parameters.AddWithValue("@dateSubmitted", qr.getDateSubmitted());
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
        public ArrayList getAllQuizResultByUserID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResult] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    QuizResult qr = new QuizResult();
                    UserDAO userDAO = new UserDAO();
                    QuizDAO quizDAO = new QuizDAO();
                    QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
                    qr.setQuizResultID((int)dr["quizResultID"]);
                    qr.setUser(userDAO.getUserByID((string)dr["userID"]));
                    qr.setQuiz(quizDAO.getQuizByID((int)dr["quizID"]));
                    qr.setScore((int)dr["score"]);
                    qr.setGrade((string)dr["grade"]);
                    qr.setQuizResultHistory(qrhDAO.getQuizResultHistoryByID((int)dr["quizResultHistoryID"]));
                    qr.setDateSubmitted(dr.GetDateTime(6));
                    toReturn.Add(qr);
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
        public Boolean getQuizResultByUserIDandQuizID(String userID, int quizID)
        {
            Boolean toReturn = false;
            SqlConnection conn = new SqlConnection();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResult] where userID=@userID and quizID=@quizID";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@quizID", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                if (dr == null || !dr.HasRows)
                {
                    toReturn = false;
                }
                else
                {
                    toReturn = true;
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