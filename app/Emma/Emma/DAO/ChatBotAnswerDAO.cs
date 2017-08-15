using Emma.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace Emma.DAO
{
    [Serializable]
    public class ChatBotAnswerDAO
    {
        public List<ChatBotAnswer> getChatBotAnswerByIntent(string intent)
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotAnswer> toReturn = new List<ChatBotAnswer>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select cba.answerID, cba.answer, cbi.intent, cba.entityName from [ChatBotAns] cba inner join [ChatBotIntent] cbi on cba.intentID = cbi.intentID where cbi.intent=@intent";
                comm.Parameters.AddWithValue("@intent", intent);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotAnswer cba = new ChatBotAnswer();
                    cba.answerID = (int)dr["answerID"];
                    cba.answer = (string)dr["answer"];
                    cba.intent = (string)dr["intent"];
                    if (!dr.IsDBNull(3))
                    {
                        cba.entityName = (string)dr["entityName"];
                    }

                    toReturn.Add(cba);
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
        public List<string> getChatBotHelpQuestions()
        {
            SqlConnection conn = new SqlConnection();
            List<string> toReturn = new List<string>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select question from [ChatBotHelpQuestion]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((string)dr["question"]);
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
        public List<string> getChatBotInitializationMessage()
        {
            SqlConnection conn = new SqlConnection();
            List<string> toReturn = new List<string>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select message from [ChatBotInitialization] order by levels asc";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((string)dr["message"]);
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
        public Boolean insertFeedback(string name, string feedback, string department, DateTime feedbackDate) // Insert.
        {
            SqlConnection conn = null;
            Boolean success = false;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [ChatBotFeedback] (name, feedback, department, feedbackDate) VALUES (@name, @feedback, @department, @feedbackDate)";
                comm.Parameters.AddWithValue("@name", name);
                comm.Parameters.AddWithValue("@feedback", feedback);
                comm.Parameters.AddWithValue("@department", department);
                comm.Parameters.AddWithValue("@feedbackDate", feedbackDate);
                comm.ExecuteNonQuery();
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
        public List<ChatBotAnswer> getAllChatBotAnswers()
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotAnswer> toReturn = new List<ChatBotAnswer>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select cba.answerID, cba.answer, cbi.intent, cba.entityName from [ChatBotAns] cba inner join [ChatBotIntent] cbi on cba.intentID = cbi.intentID";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotAnswer cba = new ChatBotAnswer();
                    cba.answerID = (int)dr["answerID"];
                    cba.answer = (string)dr["answer"];
                    cba.intent = (string)dr["intent"];
                    if (!dr.IsDBNull(3))
                    {
                        cba.entityName = (string)dr["entityName"];
                    }

                    toReturn.Add(cba);
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