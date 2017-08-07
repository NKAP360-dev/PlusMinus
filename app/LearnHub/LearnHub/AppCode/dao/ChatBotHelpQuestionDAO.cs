using Emma.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Emma.DAO
{
    public class ChatBotHelpQuestionDAO
    {
        public List<ChatBotHelpQuestion> getAllChatBotHelpQuestions()
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotHelpQuestion> toReturn = new List<ChatBotHelpQuestion>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotHelpQuestion]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotHelpQuestion cbhq = new ChatBotHelpQuestion();
                    cbhq.questionID = (int)dr["questionID"];
                    cbhq.question = (string)dr["question"];

                    toReturn.Add(cbhq);
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
        public ChatBotHelpQuestion getChatBotHelpQuestionByID(int questionID)
        {
            SqlConnection conn = new SqlConnection();
            ChatBotHelpQuestion toReturn = new ChatBotHelpQuestion();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotHelpQuestion] where questionID=@questionID";
                comm.Parameters.AddWithValue("@questionID", questionID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.questionID = (int)dr["questionID"];
                    toReturn.question = (string)dr["question"];
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
        public Boolean insertQuestion(string question) // Insert.
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
                comm.CommandText = "Insert into [ChatBotHelpQuestion] (question) VALUES (@question)";
                comm.Parameters.AddWithValue("@question", question);
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
        public void updateChatBotHelpQuestion(string question, int questionID) // Update.
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
                comm.CommandText = "Update [ChatBotHelpQuestion] SET question=@question WHERE questionID=@questionID";
                comm.Parameters.AddWithValue("@questionID", questionID);
                comm.Parameters.AddWithValue("@question", question);
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
        public void deleteQuestionByID(int questionID)
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
                comm.CommandText = "DELETE FROM [ChatBotHelpQuestion] WHERE questionID=@questionID";
                comm.Parameters.AddWithValue("@questionID", questionID);
                comm.ExecuteNonQuery();
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
    }
}