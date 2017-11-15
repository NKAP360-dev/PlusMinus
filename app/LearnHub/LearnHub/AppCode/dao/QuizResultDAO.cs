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
                    toReturn.setDateSubmitted(dr.GetDateTime(5));
                    toReturn.setAttempt((int)dr["attempt"]);
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
        public int createQuizResult(string userID, int quizID, int score, string grade, DateTime dateSubmitted, int attempt) // Insert.
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
                comm.CommandText = "Insert into [QuizResult] (userID, quizID, score, grade, dateSubmitted, attempt) OUTPUT INSERTED.quizResultID VALUES (@userID, @quizID, @score, @grade, @dateSubmitted, @attempt)";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@quizID", quizID);
                comm.Parameters.AddWithValue("@score", score);
                comm.Parameters.AddWithValue("@grade", grade);
                comm.Parameters.AddWithValue("@dateSubmitted", dateSubmitted);
                comm.Parameters.AddWithValue("@attempt", attempt);
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
                    qr.setDateSubmitted(dr.GetDateTime(5));
                    qr.setAttempt((int)dr["attempt"]);
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
                comm.CommandText = "select * from [QuizResult] where userID=@userID and quizID=@quizID and grade='pass'";
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
        public List<QuizResult> getQuizResultAttemptsByQuizIDandUserID(int quizID, string userID)
        {
            SqlConnection conn = new SqlConnection();
            List<QuizResult> toReturn = new List<QuizResult>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [QuizResult] where quizID=@quizID and userID=@userID order by attempt";
                comm.Parameters.AddWithValue("@quizID", quizID);
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
                    qr.setDateSubmitted(dr.GetDateTime(5));
                    qr.setAttempt((int)dr["attempt"]);
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
        public Boolean checkIfUserPassQuiz(String userID, int quizID)
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
                comm.CommandText = "select * from [QuizResult] where userID=@userID and quizID=@quizID and grade='pass'";
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
        public int getAttemptForQuiz(int quizID, string userID)
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
                comm.CommandText = "select count(*) from [QuizResult] where quizID=@quizID and userID=@userID";
                comm.Parameters.AddWithValue("@quizID", quizID);
                comm.Parameters.AddWithValue("@userID", userID);
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
        public ArrayList getAllQuizResultByQuizID(int quizID, string userID)
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
                comm.CommandText = "select * from [QuizResult] where quizID=@quizID and userID=@userID";
                comm.Parameters.AddWithValue("@quizID", quizID);
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
                    qr.setDateSubmitted(dr.GetDateTime(5));
                    qr.setAttempt((int)dr["attempt"]);
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
        public int getNumberOfAttempts(string userID, int quizID)
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
                comm.CommandText = "select count(*) from [QuizResult] where userID=@userID and quizID=@quizID";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@quizID", quizID);
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
        public int getNumberOfPassQuiz(string userID)
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
                comm.CommandText = "select count(DISTINCT quizID) from [QuizResult] where userID=@userID and grade='pass'";
                comm.Parameters.AddWithValue("@userID", userID);
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
        public int getNumberOfPassQuizByUserIDandCourseID(string userID, int courseID)
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
                comm.CommandText = "select count(DISTINCT qr.quizID) from [QuizResult] qr inner join [Quiz] q on qr.quizID = q.quizID where qr.userID=@userID and qr.grade='pass' and q.elearn_courseID=@courseID";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@courseID", courseID);
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